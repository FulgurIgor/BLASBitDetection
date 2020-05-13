# BlasBitDetection

This project is related to detection of contract incompability, when different version of BLAS is used.

# Compilation

```
cmake -H. -Bobjdir
cd objdir
make DDOT_BLAS32Shared
make DDOT_BLAS64Shared
make
```