set_n_least_used_CUDA_VISIBLE_DEVICES() {
    local n=${1:-"9999"}
    echo "GPU Memory Usage:"
#    local FIRST_N_GPU_IDS=$(nvidia-smi --query-gpu=memory.used --format=csv \
#        | tail -n +2 \
#        | nl -v 0 \
#        | tee /dev/tty \
#        | sort -g -k 2 \
#        | awk '{print $1}' \
#        | head -n $n)
    local FIRST_N_GPU_IDS = '0'
    export CUDA_VISIBLE_DEVICES=$(echo $FIRST_N_GPU_IDS | sed 's/ /,/g')
    echo "Now CUDA_VISIBLE_DEVICES is set to:"
    echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
}

set_n_least_used_CUDA_VISIBLE_DEVICES 2

# torchrun --standalone --nproc_per_node=2 train_dummy.py --strategy colossalai_zero2
torchrun --standalone --nproc_per_node=2 train_dummy.py --strategy colossalai_gemini --model gpt2
