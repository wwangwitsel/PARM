> README.md for code accompanying the paper "Semi-Supervised Partial Label Learning via Confidence-Rated Margin Maximization"

# PARM

This repository is the official implementation of the PARM algorithm of the paper "Semi-Supervised Partial Label Learning via Confidence-Rated Margin Maximization" and technical details of this algorithm can be found in the paper. 

## Requirements

- MATLAB, version 2014a and higher.
- MOSEK toolbox package, which can be download from https://www.mosek.com/.

Note that the MOSEK toolbox has to be licensed and the license can be applied for from https://www.mosek.com/products/academic-licenses/ for free for academic purpose. It has to be reset in the appropriate location as instructed by the MATLAB command we you run the demo code.

To start, 
- Create a directory of your choice and copy the toolbox there.
- Set the path in your MATLAB to add the directory you just created.

Then, run this command to enter the MATLAB environment:
```
matlab
```
## code structure

To see the structure of the source code, run this command in MATLAB command:

```
help PARM_code
```

To see the interface details of the training function, run this command in MATLAB command:

```
help PARM_train
```

To see the interface details of the testing function, run this command in MATLAB command:

```
help PARM_predict
```

## demo
This repository provides a demo, i.e. demo.m, which shows the training and testing phase of PARM.
Before run demo.m, please rename the variable 'mosek_path' as the path containing  quadprog.m of the MOSEK toolbox package. The detailed comments can be found in demo.m.

To run demo.m, run this command in MATLAB command:

```
demo
```
## hyperparameter setting
The performance of PARM is somewhat sensitive w.r.t. $\lambda$ and $\mu$, whose values are chosen from {0.001,0.005,0.01,0.05,0.1,0.5,1,5,10} via cross validation on the training set. Here we provide some hyperparameter settings for the data sets in our paper:



| Data set name      | $\lambda$  |   $\mu$   |
| ------------------ |---------------- | -------------- |
| Deter   | 10  |  0.5   |
| Vehicle | 10 | 1 |
| Abalone       | 0.01 | 0.01 |
| Satimage | 5 | 0.1 |
| Lost | 0.001 | 0.001 |
| Mirflickr | 0.1 | 0.01 |
| BirdSong | 5 | 1 |
| LYN10 | 10 | 1 |
| LYN20 | 10 | 1 |
