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
                $ sudo singularity run python3.sif -c "print('hello world')"    #inline execution
```
