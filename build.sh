nasm -f elf64 match.asm -o match.o
ld match.o -o match
echo "run build with ./match"
