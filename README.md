# scientiflow-singularity

### Build with Singularity

```bash
$ sudo singularity build --sandbox python3.sif python3.def
```

### Run with Singularity

```bash
        # Run singularity test python3.sif to check installation
        # Run singularity run python3.sif "any valid argument to the python interpreter"

        # Example:
                singularity run python3.sif -c "print('hello world')"    #inline execution
```

### Singularity Commands

```bash
# build with:
sudo singularity build gromacs-24.3.sif gromacs-24.3.def

# Todo add gmx to path inside the docker container
singularity exec gromacs-24.3.sif /usr/local/gromacs/bin/gmx
```
