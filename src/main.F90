program main
    implicit none
    ! DDOT function from BLAS
    double precision DDOT
    ! IDAMAX function from BLAS
    integer(kind=IP) IDAMAX
    ! size of double precision array
    integer(kind=IP), parameter :: N = 3, STEP = 4294967297
    ! array
    double precision :: A(N), B(N)
    ! dot product
    double precision :: DOT
    ! idamax value
    integer(kind=IP) :: DAMAX
    A = (/ 1.0, 2.0, 3.0 /)
    B = (/ 1.0, 2.0, 3.0 /)
    write(6,"(A,I2,A)") "Library: ", LIBRARY, " bit"
    write(6,"(A,I2,A)") "Program: ", PROGRAM, " bit"
    flush(6)
    DOT = DDOT(N, A, STEP, B, STEP)
    write(6,"(F6.2)") DOT
    DAMAX = IDAMAX(N,A,STEP)
    write(6,"(I3)") DAMAX
end program main