# Bio-Edu Command Line and HPC Workshop

This workshop is a practical introduction to:

- using the command line
- understanding basic Linux shell workflows
- running work on HPC systems
- submitting jobs with PBS at NCI

## 1. What Is the Command Line?

The command line interface (CLI) lets you interact with a computer by typing commands into a terminal instead of clicking through a graphical interface.

Why it matters:

- it is fast for repetitive tasks
- it is the standard way to work on Linux servers and HPC systems
- it makes automation possible through scripts

## 2. Windows vs Unix/Linux

Most HPC systems use Linux, so a Linux-like shell environment is the best preparation.

### macOS and Linux

- already include a Unix shell
- use `Terminal`, `iTerm2`, or similar terminal applications

### Windows

Recommended options:

1. **WSL (Windows Subsystem for Linux)**  
   Best for compatibility with Linux commands, shell scripts, and HPC workflows.

2. **PuTTY**  
   Easier to get started for SSH access only, but it does not give you a full Linux environment on your own machine.

Rule of thumb:

- use **WSL** if you want to practice Linux properly
- use **PuTTY** if you only need a simple SSH client quickly

## 3. Common Command Line Commands

| Command | Purpose | Example |
| --- | --- | --- |
| `pwd` | show current directory | `pwd` |
| `ls` | list files | `ls -lah` |
| `cd` | change directory | `cd data` |
| `mkdir` | create directory | `mkdir results` |
| `cp` | copy files | `cp input.txt backup.txt` |
| `mv` | move or rename files | `mv old.txt new.txt` |
| `rm` | remove files | `rm notes.txt` |
| `cat` | print file contents | `cat script.sh` |
| `less` | view long files | `less README.md` |
| `head` | show first lines | `head data.csv` |
| `tail` | show last lines | `tail log.txt` |
| `echo` | print text | `echo "hello"` |
| `wc` | count lines/words/chars | `wc -l file.txt` |
| `find` | locate files | `find . -name "*.txt"` |
| `ssh` | connect to remote machine | `ssh username@host` |
| `scp` | copy files over SSH | `scp file.txt username@host:/path/` |

## 4. CLI Cheat Sheet

### Navigation

```bash
pwd
ls
ls -lah
cd folder_name
cd ..
cd ~
```

### Files and directories

```bash
mkdir new_folder
cp file1.txt file2.txt
mv oldname.txt newname.txt
rm file.txt
rm -r folder_name
```

### Viewing files

```bash
cat file.txt
less file.txt
head file.txt
tail file.txt
```

### Remote access

```bash
ssh username@host
scp local.txt username@host:/remote/path/
```

## 5. Man Pages

Manual pages are built-in documentation for many commands.

Examples:

```bash
man ls
man grep
man ssh
```

Useful pattern:

```bash
command --help
```

Examples:

```bash
grep --help
ssh --help
qsub --help
```

## 6. Powerful Shell Tools

These tools are worth learning early because they scale well from simple use to real data work.

### `grep`

Search text for patterns:

```bash
grep "ERROR" logfile.txt
grep -i "sample" names.txt
grep -r "PBS" .
```

### `awk`

Extract or process columns of text:

```bash
awk '{print $1}' file.txt
awk -F, '{print $2}' data.csv
```

### `while`

Loop through input:

```bash
while read line
do
  echo "$line"
done < names.txt
```

### GNU `parallel`

Run multiple tasks at once:

```bash
parallel echo {} ::: sample1 sample2 sample3
```

This is very useful when you have many similar jobs to run.

## 7. Very Brief Intro to Bash Scripts

A shell script is a text file containing commands that run in sequence.

Example script:

```bash
#!/bin/bash
echo "Starting job"
pwd
date
echo "Finished"
```

Save it as `hello.sh`.

## 8. How to Run a Script

Option 1:

```bash
bash hello.sh
```

Option 2:

```bash
chmod +x hello.sh
./hello.sh
```

The first line, `#!/bin/bash`, is called a **shebang**. It tells the system which interpreter to use.

## 9. What Is HPC?

HPC stands for **High Performance Computing**.

It means using powerful shared systems with many CPUs, large memory, and job schedulers to run workloads that are too big, too slow, or too numerous for a laptop.

Typical HPC use cases:

- large simulations
- bioinformatics pipelines
- climate and earth system modelling
- machine learning at scale
- data analysis on large datasets

## 10. HPC Systems: NCI, Pawsey, and Katana

Examples of Australian HPC systems:

- **NCI**: National Computational Infrastructure
- **Pawsey**: Pawsey Supercomputing Research Centre
- **Katana**: UNSW research computing cluster

The exact commands and policies vary, but the core ideas are similar:

- log in remotely
- prepare files and scripts
- request resources through a scheduler
- submit jobs to queues
- collect outputs

## 11. Login Nodes and Worker Nodes

### Login nodes

Used for:

- logging in
- editing files
- moving data
- preparing and submitting jobs

Do **not** use login nodes for large or long-running compute tasks.

### Worker nodes

Used for:

- running compute jobs
- using requested CPUs and memory
- executing scheduled workloads

Your work usually runs on worker nodes only after being submitted through the scheduler.

## 12. Queues and Limits

HPC systems manage jobs through queues.

Queues help control:

- job priority
- walltime limits
- CPU and memory usage
- fair sharing between users and projects

Typical limits include:

- number of CPUs
- memory
- walltime
- storage quotas
- maximum jobs per user or project

Important idea:

- if you ask for too many resources, your job may wait longer
- if you ask for too little, your job may fail

## 13. PBS at NCI

PBS stands for **Portable Batch System**. At NCI, it is used to submit and manage jobs.

Common PBS commands:

| Command | Purpose |
| --- | --- |
| `qsub job.pbs` | submit a job |
| `qstat` | check job status |
| `qstat -u $USER` | list your jobs |
| `qdel JOBID` | cancel a job |

## 14. Example PBS Job Script

```bash
#!/bin/bash
#PBS -P your_project_code
#PBS -q normal
#PBS -l walltime=00:01:00
#PBS -l ncpus=1
#PBS -l mem=1GB
#PBS -l jobfs=1GB
#PBS -l storage=gdata/your_project_code
#PBS -N hello_job
#PBS -l wd

echo "Hello from NCI"
hostname
date
```

Save this as `hello.pbs`.

## 15. Submit a Hello World Job

Submit:

```bash
qsub hello.pbs
```

Check status:

```bash
qstat -u $USER
```

Possible states:

- `Q` = queued
- `R` = running
- job disappears from `qstat` when it has finished

Output is usually written to files in your working directory.

## 16. Suggested Live Demo Flow

If you want to teach this as a short workshop, a simple sequence is:

1. open a terminal
2. navigate directories with `pwd`, `ls`, and `cd`
3. create and inspect files
4. show `man ls` and `grep --help`
5. run a small shell script
6. explain login nodes vs worker nodes
7. show a PBS script
8. submit a hello world job with `qsub`
9. monitor it with `qstat`

## 17. Key Takeaways

- the command line is essential for Linux servers and HPC
- Linux skills transfer well across systems
- scripts save time and improve reproducibility
- HPC systems use schedulers, so jobs are submitted rather than run directly
- NCI uses PBS to manage compute jobs

---

## Optional Practice Exercises

1. Create a directory called `workshop` and move into it.
2. Create a file called `notes.txt` and add a few lines of text.
3. Use `cat`, `head`, and `tail` to inspect the file.
4. Use `grep` to search for a word in the file.
5. Write a small `hello.sh` script and run it.
6. Read a PBS script and identify the resource requests.
