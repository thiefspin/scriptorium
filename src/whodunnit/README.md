# whodunnit

A lightweight Git contribution analyzer that provides insights into code authorship and change metrics across your repository.

## Overview

`whodunnit.sh` is a Bash script that analyzes Git repository history to show per-author statistics including commits, lines added, lines deleted, and total churn (lines changed). It's perfect for understanding contribution patterns, code ownership, and development activity in your projects.

## Features

- 📊 **Comprehensive Statistics**: Track commits, additions, deletions, and total churn per author
- 🚀 **Fast & Lightweight**: Pure Bash/AWK implementation with no external dependencies beyond Git
- 🎯 **Flexible Filtering**: Supports path-specific analysis using Git's pathspec syntax
- 🔧 **Merge-Aware**: Excludes merge commits for more accurate contribution metrics
- 📋 **Clean Output**: Formatted table output sorted by contribution volume

## Installation

### Quick Install

```bash
# Download the script
curl -O https://raw.githubusercontent.com/yourusername/whodunnit/main/whodunnit.sh

# Make it executable
chmod +x whodunnit.sh

# Optional: Move to your PATH
sudo mv whodunnit.sh /usr/local/bin/whodunnit
```

### Manual Installation

1. Clone this repository or download the `whodunnit.sh` file
2. Make the script executable: `chmod +x whodunnit.sh`
3. Optionally, add it to your PATH for system-wide access

## Usage

### Basic Usage

Analyze the entire repository:
```bash
./whodunnit.sh
```

### Filtered Analysis

Analyze specific paths or files:
```bash
# Analyze a specific directory
./whodunnit.sh src/

# Analyze multiple paths
./whodunnit.sh src/ docs/ README.md

# Analyze specific file types
./whodunnit.sh '*.js' '*.ts'

# Analyze with Git pathspec patterns
./whodunnit.sh ':(glob)**/*.py'
```

### Sample Output

```
Author                          Commits        Added      Deleted        Churn
Jane Developer                      142        15234         8921        24155
John Coder                           89        12453         5672        18125
Alice Programmer                     67         8934         3201        12135
Bob Engineer                         45         5621         2103         7724
```

## How It Works

The script leverages Git's powerful log command with the `--numstat` option to extract detailed change information for each commit. It then processes this data through AWK to:

1. Parse commit authorship information
2. Calculate additions and deletions per author
3. Compute total churn (additions + deletions)
4. Format and sort results by total contribution

### Key Implementation Details

- **Merge Commits**: Excluded via `--no-merges` to prevent skewing statistics
- **Binary Files**: Handled gracefully (marked as "-" in Git's output)
- **Path Handling**: Uses `core.quotepath=off` for proper Unicode filename support
- **Sorting**: Results are sorted by churn (total lines changed) in descending order

## Requirements

- Git (any recent version)
- Bash 4.0+
- AWK (any POSIX-compliant version)

These requirements are typically met by default on:
- macOS
- Linux (all major distributions)
- Windows (via Git Bash, WSL, or Cygwin)

## Use Cases

- **Code Reviews**: Identify primary contributors to specific modules
- **Refactoring**: Understand who has the most context about code sections
- **Team Analytics**: Track contribution patterns and workload distribution
- **Project Handoffs**: Document code ownership for knowledge transfer
- **Open Source**: Recognize contributor efforts with concrete metrics

## Performance

The script is optimized for performance and can handle:
- Repositories with 100,000+ commits
- Large monorepos with extensive history
- Complex path filtering without significant slowdown

Performance scales linearly with repository size and the number of commits being analyzed.

## Limitations

- Does not track file renames separately (counts as deletion + addition)
- Binary file changes are not counted in line statistics
- Does not differentiate between code, comments, and whitespace changes
- Requires local Git repository access (doesn't work with remote URLs)

## Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

### Development Guidelines

1. Maintain POSIX compliance where possible
2. Preserve backward compatibility
3. Add comments for complex AWK expressions
4. Test with various repository sizes and structures

## License

MIT License - see [LICENSE](LICENSE) file for details

## Similar Tools

While `whodunnit` focuses on simplicity and portability, you might also be interested in:

- `git-quick-stats` - More comprehensive Git statistics
- `git-fame` - Similar functionality with additional features
- `github-contributors` - For GitHub-specific analytics
- `git shortlog -sn` - Built-in Git alternative (commits only)

## Acknowledgments

Inspired by the need for a simple, fast, and reliable way to analyze Git contributions without external dependencies or complex installations.

---

**Quick Tip**: Alias it for convenience:
```bash
echo "alias whodunnit='~/path/to/whodunnit.sh'" >> ~/.bashrc
```
