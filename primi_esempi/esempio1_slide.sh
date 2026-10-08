# fileinutile:
# risponde "sì" se invocato con "sì"
# e un numero <= 24
if test $1 = sì -a $2 -le 24
then echo sì
else echo no
fi