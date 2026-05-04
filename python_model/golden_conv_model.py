import numpy as np
import matplotlib.pyplot as plt

FRAC = 4
SCALE = 1 << FRAC

def q44(x):
    return np.clip(np.round(x * SCALE), -128, 127).astype(np.int8)

def relu_sat_q44(acc):
    shifted = acc >> FRAC
    return np.clip(shifted, 0, 127).astype(np.int16)

def conv2d_q44(image_q, kernel_q, bias_q=0):
    h, w = image_q.shape
    out = np.zeros((h-2, w-2), dtype=np.int16)
    accs = np.zeros_like(out, dtype=np.int32)
    for i in range(h-2):
        for j in range(w-2):
            window = image_q[i:i+3, j:j+3].astype(np.int32)
            acc = int(np.sum(window * kernel_q.astype(np.int32)) + bias_q)
            accs[i,j] = acc
            out[i,j] = relu_sat_q44(acc)
    return out, accs

if __name__ == '__main__':
    image = np.array([
        [0.2,0.3,0.4,0.6,0.7,0.8],
        [0.2,0.3,0.4,0.6,0.7,0.8],
        [0.2,0.3,0.4,0.6,0.7,0.8],
        [0.1,0.2,0.3,0.5,0.6,0.7],
        [0.1,0.2,0.3,0.5,0.6,0.7],
        [0.0,0.1,0.2,0.4,0.5,0.6],
    ])
    kernel = np.array([[-1,0,1],[-2,0,2],[-1,0,1]], dtype=float)
    iq = q44(image); kq = q44(kernel)
    out, acc = conv2d_q44(iq, kq)
    print('Quantized image:')
    print(iq)
    print('Quantized kernel:')
    print(kq)
    print('Output Q4.4 integer:')
    print(out)
    np.savetxt('results/data/golden_output.csv', out, fmt='%d', delimiter=',')
    plt.figure(figsize=(5,4))
    plt.imshow(out, cmap='viridis')
    plt.title('Quantized CNN Convolution Output')
    plt.colorbar(label='Q4.4 integer output')
    plt.tight_layout()
    plt.savefig('results/plots/golden_output_heatmap.png', dpi=200)
