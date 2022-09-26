
# Some other aliases
function scst { scoop update; scoop status }

function rename-ext {
  $ext = $args[0]
  $offset = $args[1]
  foreach ($file in (Get-ChildItem *.$ext)) {
    Rename-Item -Path $file -NewName $file.Name.SubString($offset)
  }
}

Set-Alias -Name vi -Value vim

Set-Alias -Name python3 -Value python

Set-Alias -Name python2 -Value "C:\Python27\python.exe"
Set-Alias -Name py2 -Value "C:\Python27\python.exe"

Set-Alias -Name emulator -Value "C:\Users\VailG\AppData\Local\Android\Sdk\emulator\emulator.exe"
Set-Alias -Name adb -Value "C:\Users\VailG\AppData\Local\Android\Sdk\platform-tools\adb.exe"

function conda-activate($conda_env = "C:\Users\VailG\miniconda3") {
  pwsh -ExecutionPolicy ByPass -NoExit -Command "& 'C:\Users\VailG\miniconda3\shell\condabin\conda-hook.ps1' ; conda activate ${conda_env} ; Set-PoshPrompt pure "
}

function ffmpeg-download($url, $origin, $referer, $outpath) {
  $userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101 Firefox/87.0"
  ffmpeg -user_agent $userAgent -headers "origin:${origin}" -headers "referer:${referer}" -protocol_whitelist file, http, https, tcp, tls, crypto -i $url -c copy $outpath
}

function networth($buyback) {
  ($buyback - 200) * 13
}

function nvenc() {
  foreach ($arg in $args) {
    foreach ($filename in $arg) {
      if (Test-Path $filename) {
        $file = (Get-Item $filename)
        $dirName = $file.DirectoryName
        $baseName = $file.BaseName
        $outpath = "${dirName}\nvenc-${baseName}.mp4"
        ffmpeg -i $filename -vcodec hevc_nvenc $outPath
      }
    }
  }
}

function leetcode() {
  # convert leetcode title to filename
  $trimmed = "$args".trim()
  $textinfo = (get-culture).textinfo
  $left = $trimmed.split(' ')
  $result = ""
  foreach ($word in $left) {
    $result += $textinfo.totitlecase($word)
  }
  $result = "./algorithms/${result}.py"

  code $result
  # set-clipboard -Value $result
  # return $result
}

function  remove-duplicate() {
  ls * -recurse | get-filehash | group -property hash | where { $_.count -gt 1 } | % { $_.group | select -skip 1 } | del
}

function rgf() {
  rg --files | rg --smart-case ${args}
}

function sendkeys([int]${sleeptime} = 1, [string]${key} = ' ') {
  echo "Press Ctrl-c to stop"
  $wshell = New-Object -ComObject wscript.shell;
  while ($true) {
    # $wshell.AppActivate('title of the application window')
    Sleep ${sleeptime}
    $wshell.SendKeys(${key})
  }
}

function phone() {
  scrcpy --max-size 1200 -b 16M --turn-screen-off --stay-awake
}

function Get-DirectorySize {
  <#
.SYNOPSIS
Gets the logical size of directories in bytes.

.DESCRIPTION
Given a literal directory path, output that directory's logical size, i.e.,
the sum of all files contained in the directory, including hidden ones.

NOTE:
* The logical size is distinct from the size on disk, given that files
  are stored in fixed-size blocks. Furthermore, files can be compressed
  or sparse.
  Thus, the size of regular files on disk is typically greater than
  their logical size; conversely, compressed and sparse files require less
  disk space.
  Finally, the list of child items maintained by the filesystem for each
  directory requires disk space too.

* Wildcard expressions aren't directly supported, but you may pipe in
  Output from Get-ChildItem / Get-Item; if files rather than directotries
  happen to be among the input objects, their size is reported as-is.

CAVEATS:
 * Can take a long time to run with large directory trees, especially with
   -Recurse.
* Recursion is implemented inefficently.

.PARAMETER LiteralPath
The literal path of a directory. May be provided via the pipeline.

.PARAMETER Recurse
Calculates the logical size not only of the input directory itself, but of
all subdirectories in its subtree too.
To limit the recursion depth, use -Depth.

.PARAMETER Depth
Limits the recursion depth to the specified number of levels. Implies -Recurse.
Note that 0 means no recursion. Use just -Recurse in order not to limit the
recursion.

.PARAMETER ExcludeSelf
Excludes the target directory itself from the size calculation.
Implies -Recurse. Since -Depth implies -Recurse, you could use -ExcludeSelf
-Depth 1 to report only the sizes of the immediate subdirectories.

.OUTPUTS
[pscustomobject] instances with properties FullName, Size, and FriendlySize.

.EXAMPLE
Get-DirectorySize

Gets the logical size of the current directory.

.EXAMPLE
Get-DirectorySize -Recurse

Gets the logical size of the current directory and all its subdirectories.

.EXAMPLE
Get-DirectorySize /path/to -ExcludeSelf -Depth 1 | Sort-Object Size

Gets the logical size of all child directories in /path/to without including
/path/to itself, and sorts the result by size (largest last).
#>

  param(
    [Parameter(ValueFromPipeline)] [Alias('PSPath')]
    [string] $LiteralPath = '.',
    [switch] $Recurse,
    [switch] $ExcludeSelf,
    [int] $Depth = -1,
    [int] $__ThisDepth = 0 # internal use only
  )

  process {

    # Resolve to a full filesystem path, if necessary
    $fullName = if ($__ThisDepth) { $LiteralPath } else { Convert-Path -ErrorAction Stop -LiteralPath $LiteralPath }

    if ($ExcludeSelf) {
      # Exclude the input dir. itself; implies -Recurse

      $Recurse = $True
      $ExcludeSelf = $False

    }
    else {
      # Process this dir.

      # Calculate this dir's total logical size.
      # Note: [System.IO.DirectoryInfo].EnumerateFiles() would be faster,
      # but cannot handle inaccessible directories.
      $size = [Linq.Enumerable]::Sum(
        [long[]] (Get-ChildItem -Force -Recurse -File -LiteralPath $fullName).ForEach('Length')
      )

      # Create a friendly representation of the size.
      $decimalPlaces = 2
      $padWidth = 8
      $scaledSize = switch ([double] $size) {
        { $_ -ge 1tb } { $_ / 1tb; $suffix = 'tb'; break }
        { $_ -ge 1gb } { $_ / 1gb; $suffix = 'gb'; break }
        { $_ -ge 1mb } { $_ / 1mb; $suffix = 'mb'; break }
        { $_ -ge 1kb } { $_ / 1kb; $suffix = 'kb'; break }
        default { $_; $suffix = 'b'; $decimalPlaces = 0; break }
      }

      # Construct and output an object representing the dir. at hand.
      [pscustomobject] @{
        FullName     = $fullName
        FriendlySize = ("{0:N${decimalPlaces}}${suffix}" -f $scaledSize).PadLeft($padWidth, ' ')
        Size         = $size
      }

    }

    # Recurse, if requested.
    if ($Recurse -or $Depth -ge 1) {
      if ($Depth -lt 0 -or (++$__ThisDepth) -le $Depth) {
        # Note: This top-down recursion is inefficient, because any given directory's
        #       subtree is processed in full.
        Get-ChildItem -Force -Directory -LiteralPath $fullName |
        ForEach-Object { Get-DirectorySize -LiteralPath $_.FullName -Recurse -Depth $Depth -__ThisDepth $__ThisDepth }
      }
    }

  }

}
