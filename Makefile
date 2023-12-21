BASEDIR=/root/github/

CLANG=clang
LLC=llc
INLCUDE_SYS=/usr/include
INCLUDE_LOC=/include
XDP_TARGETS := ratelimiting_kern 
XDP_USER_TARGETS := ratelimiting_user

BPF_CFLAGS ?= -I$(INLCUDE_SYS) -I$(INCLUDE_LOC)

XDP_C = ${XDP_TARGETS:=.c}
XDP_OBJ = ${XDP_C:.c=.o}
XDP_USER_C = ${XDP_USER_TARGETS:=.c}
XDP_USER_OBJ = ${XDP_USER_C:.c=.o}

$(info XDP_OBJ="$(XDP_OBJ)")
$(info XDP_C="$(XDP_C)")

all: $(XDP_OBJ) #$(XDP_USER_OBJ)

$(XDP_OBJ): %.o: %.c 
	$(CLANG)   $(BPF_CFLAGS) \
	-DDEBUG -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
        -Wno-compare-distinct-pointer-types \
	-O2 -emit-llvm -c -g -o  ${@:.o=.ll} $<
	$(LLC) -march=bpf -filetype=obj -o $@ ${@:.o=.ll}

$(XDP_USER_OBJ): %.o: %.c 
	$(CLANG)   $(BPF_CFLAGS) \
	-DDEBUG -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
        -Wno-compare-distinct-pointer-types \
	-O2 -emit-llvm -c -g -o  ${@:.o=.ll} $<
	$(LLC) -march=bpf -filetype=obj -o $@ ${@:.o=.ll}