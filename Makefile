

CC := nvcc

INCLUDE := $(CUDA_DIR)/include

SRC = hotspot.cu
TSRC = thrustHotspot.cu
EXE = hotspot
TEXE = thotspot
run: $(EXE)
	./$(EXE) 64 2 2 temp	power result.out
	openssl md5 result.out

$(EXE): $(SRC)
	$(CC) $(KERNEL_DIM) $(SRC) -o $(EXE) -I$(INCLUDE)

enum: $(SRC)
	$(CC) $(KERNEL_DIM) -deviceemu $(SRC) -o $(EXE) -I$(INCLUDE) -L$(CUDA_LIB_DIR)

debug: $(SRC)
	$(CC) $(KERNEL_DIM) -g $(SRC) -o $(EXE) -I$(INCLUDE) -L$(CUDA_LIB_DIR)

debugenum: $(SRC)
	$(CC) $(KERNEL_DIM) -g -deviceemu $(SRC) -o $(EXE) -I$(INCLUDE) -L$(CUDA_LIB_DIR)

clean: $(SRC)
	rm -f $(EXE) $(EXE).linkinfo result.txt

trun: $(TEXE)
		./$(TEXE) 64 2 2 temp	power result.out
		openssl md5 result.out
$(TEXE): $(TSRC)
	$(CC) $(KERNEL_DIM) $(TSRC) -o $(TEXE) -I$(INCLUDE)
