.PHONY: clean run

OBJS=parallel.o fact.o

run: parallel
	./$<

parallel: $(OBJS)
	gcc -o parallel $(OBJS)

%.o: %.c
	gcc -c -o $@ $<

# parallel.c: fact.h
# fact.c: fact.h

clean:
	rm -f parallel *.o *~ *.a
 
