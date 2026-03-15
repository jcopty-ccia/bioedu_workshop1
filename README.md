# Command Line and HPC Workshop

This repository is a beginner-friendly workshop for introducing:

- the command line
- basic Linux shell skills
- simple shell scripting
- HPC concepts
- PBS job submission on NCI

The workshop is designed so participants can do most of the work **after logging in to NCI**, which makes it practical for a mixed audience using Windows, macOS, and Linux.

## Workshop goals

By the end of the session, participants should be able to:

- connect to NCI
- navigate files and folders from the command line
- use command help and man pages
- inspect and edit simple shell scripts
- run a small script on the login node
- understand login nodes vs worker nodes
- submit a simple PBS job with `qsub`

## Recommended setup

### macOS and Linux

Use your normal terminal application, for example:

- `Terminal`
- `iTerm2`

### Windows

For a workshop, **PuTTY** is the simplest option.

- [PuTTY download page](https://www.putty.org/index.html)

`WSL` is also a good option long term, but it can take more time to set up and may require permissions that workshop participants do not have.

## Logging in to NCI

NCI's Gadi login host is:

```text
gadi.nci.org.au
```

### Using OpenSSH

```bash
ssh your_nci_username@gadi.nci.org.au
```

Example:

```bash
ssh abc123@gadi.nci.org.au
```

### Using PuTTY

1. Open PuTTY.
2. In **Host Name (or IP address)** enter `gadi.nci.org.au`.
3. Make sure the connection type is `SSH`.
4. Leave the port as `22`.
5. Click **Open**.
6. When prompted for `login as:`, enter your NCI username.
7. Enter your password.

Notes:

- the first login may prompt you to trust the host key
- when you type your password, nothing appears on the screen; this is normal
- after login, you are on a **login node**

## Git clone the workshop repo

Once logged in to NCI, clone the repository:

```bash
git clone <your-repo-url>
cd workshop
```

If Git is not available or you do not want to teach Git live, participants can also work from a pre-provided folder.

## What is in this repository?

```text
README.md
data/
  samples.tsv
scripts/
  hello.sh
  if_example.sh
  while_example.sh
pbs/
  hello.pbs
  report_samples.pbs
```

## Quick command line cheat sheet

| Command | Purpose | Example |
| --- | --- | --- |
| `pwd` | print current directory | `pwd` |
| `ls` | list files | `ls -lah` |
| `cd` | change directory | `cd scripts` |
| `mkdir` | create a folder | `mkdir practice` |
| `mv` | move or rename | `mv old.txt new.txt` |
| `cp` | copy a file | `cp a.txt b.txt` |
| `cat` | print a file | `cat README.md` |
| `less` | view a file page by page | `less README.md` |
| `head` | first lines of a file | `head data/samples.tsv` |
| `tail` | last lines of a file | `tail data/samples.tsv` |
| `grep` | search text | `grep COMPLETE data/samples.tsv` |
| `awk` | work with columns | `awk 'NR > 1 {print $2}' data/samples.tsv` |
| `man` | open manual page | `man ls` |

## Man pages and help

Useful examples:

```bash
man ls
man grep
man ssh
grep --help
qsub --help
```

## Brief shell scripting concepts

A shell script is a text file containing commands that run in order.

This workshop introduces:

- a simple script
- an `if` statement
- a `while` loop

### Running a script

Option 1:

```bash
bash scripts/hello.sh
```

Option 2:

```bash
chmod +x scripts/hello.sh
./scripts/hello.sh
```

## HPC concepts

### What is HPC?

HPC stands for **High Performance Computing**.

It refers to using shared computing systems with many CPUs, large memory, and job schedulers to run workloads larger than you would normally run on a laptop.

### Login nodes vs worker nodes

**Login nodes** are for:

- logging in
- editing files
- moving data
- preparing and submitting jobs

**Worker nodes** are for:

- running compute jobs
- using CPUs and memory requested through the scheduler
- batch processing

Do not run heavy compute directly on the login node.

### Queues and limits

Schedulers use queues to manage:

- walltime
- CPUs
- memory
- storage
- fair sharing between users and projects

If you request too many resources, your job may wait longer. If you request too few, your job may fail.

### NCI, PBS, and other HPC systems

Examples of Australian HPC systems:

- **NCI**
- **Pawsey**
- **Katana (UNSW)**

The ideas are similar across systems even if commands and policies differ.

At NCI, PBS is used to submit and manage jobs.

Common PBS commands:

| Command | Purpose |
| --- | --- |
| `qsub job.pbs` | submit a job |
| `qstat` | check jobs |
| `qstat -u $USER` | check your jobs |
| `qdel JOBID` | cancel a job |

## Hands-on exercises

These exercises assume participants are logged into NCI and are working inside this repository.

### Task 1: Navigate and manage folders

Goal: get comfortable moving around the filesystem.

Try:

```bash
pwd
ls
mkdir practice
cd practice
mkdir task1
mv task1 renamed_task1
ls
cd ..
```

Suggested discussion:

- What does `pwd` show?
- What changed after `cd`?
- What is the difference between creating and renaming a folder?

### Task 2: Explore commands and options

Goal: learn how to discover command behaviour.

Try:

```bash
pwd
ls
ls -l
ls -la
man ls
man pwd
head data/samples.tsv
tail data/samples.tsv
```

Suggested challenges:

- Find out what `-l` means.
- Find out what `-a` means.
- Compare `cat`, `less`, `head`, and `tail`.

### Task 3: Search and inspect text with `grep` and `awk`

Goal: use a small data file to practice searching and working with columns.

The file is:

```text
data/samples.tsv
```

Look at it first:

```bash
cat data/samples.tsv
```

Try these commands:

```bash
grep COMPLETE data/samples.tsv
grep koala data/samples.tsv
grep FAILED data/samples.tsv
awk 'NR > 1 {print $2}' data/samples.tsv
awk 'NR > 1 {print $1, $3}' data/samples.tsv
```

Suggested mini tasks:

- find all samples with status `COMPLETE`
- find all lines for project `koala`
- print only the sample ID column
- print the sample ID and status columns

Extension:

```bash
awk 'NR > 1 {print $2}' data/samples.tsv | sort | uniq
```

Ask participants:

- Which project names appear in the file?
- Which samples failed?

### Task 4: Run a shell script

Goal: understand that a script is a sequence of commands.

Inspect the script:

```bash
cat scripts/hello.sh
```

Run it:

```bash
bash scripts/hello.sh
```

Then discuss:

- What did the script print?
- Which command showed the working directory?
- Which command showed the machine name?

### Task 5: Intro to `if` statements

Goal: show how scripts can make decisions.

Inspect:

```bash
cat scripts/if_example.sh
```

Run:

```bash
bash scripts/if_example.sh
```

Prompt:

- What condition is being tested?
- What happens if the file exists?
- What would happen if the file name were wrong?

### Task 6: Intro to `while` loops

Goal: show repetition in shell scripts.

Inspect:

```bash
cat scripts/while_example.sh
```

Run:

```bash
bash scripts/while_example.sh
```

Prompt:

- How many times does the loop run?
- What happens in the second part of the script?
- Where is the input data coming from?

### Task 7: Submit a PBS job to NCI

Goal: move from running a script interactively to submitting it through the scheduler.

Inspect the PBS script:

```bash
cat pbs/hello.pbs
```

Submit it:

```bash
qsub pbs/hello.pbs
```

Check its status:

```bash
qstat -u $USER
```

Suggested discussion:

- What do the `#PBS` lines mean?
- Why submit with `qsub` instead of running directly?
- What is the difference between the login node and the worker node?

### Task 8: Submit a second PBS job that uses `grep` and `awk`

Goal: show that batch jobs can run normal shell commands too.

Inspect:

```bash
cat pbs/report_samples.pbs
```

Submit:

```bash
qsub pbs/report_samples.pbs
```

Then check:

```bash
qstat -u $USER
ls
```

Look for the output files and inspect them with `cat` or `less`.

## Example PBS script

```bash
#!/bin/bash
#PBS -P your_project_code
#PBS -q normal
#PBS -l walltime=00:01:00
#PBS -l ncpus=1
#PBS -l mem=1GB
#PBS -l jobfs=1GB
#PBS -l wd
#PBS -N hello_workshop

bash scripts/hello.sh
```

Update `your_project_code` before using the PBS scripts.

## Suggested delivery flow

One possible workshop sequence:

1. log in to NCI
2. clone the repo
3. explore files and folders
4. use `man`, `ls`, `head`, and `tail`
5. search the sample text file with `grep` and `awk`
6. run a shell script
7. inspect a simple `if` statement
8. inspect a simple `while` loop
9. submit a PBS job
10. inspect output files

## Teaching notes

- use PuTTY as the default Windows path for a beginner workshop
- keep work on the login node lightweight
- use PBS submission to move actual jobs onto worker nodes
- do not depend on participants having their own scripts
- use the provided files so everyone starts from the same point

## Optional extension ideas

If time permits, participants can:

- edit `hello.sh` and add another command
- modify `if_example.sh` to check for a different file
- change `while_example.sh` to count to 5
- write a new `grep` command to find `FAILED` samples
- modify the PBS job name in the `.pbs` file
