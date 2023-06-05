RQ1_dict = {"Inefficient coding for target micro-architecure": {
        "Count": 58,
        "Percentage": 31.18,
        "Sub-Category": {
            "Memory/Data locality": {
                "Count": 36,
                "Percentage": 19.35,
                "Sub-Sub-Category": {
                    "Intra-thread data locality": {
                        "Count": 32,
                        "Percentage": 17.2,
                        "Sub-Sub-Sub-Category": "cache locality",
                    },
                    "Inter-thread Data locality": {
                        "Count": 4,
                        "Percentage": 2.15,
                        "Sub-Sub-Sub-Category": "cache locality",
                    },
                },
            },
            "Micro-architectural inefficiency": {
                "Count": 22,
                "Percentage": 11.83,
                "Sub-Sub-Category": {
                    "Missed compiler loop optimization": {
                        "Count": 9,
                        "Percentage": 4.84,
                        "Sub-Sub-Sub-Category": [
                            "missed unrolling",
                            "unnecessary branch",
                            "missed function inlining",
                        ],
                    },
                    "Loop carried dependence": {"Count": 1},
                    "suboptimal computational kernel size for the target": {
                        "Count": 6,
                        "Percentage": 3.23,
                        "Sub-Sub-Sub-Category": [
                            "Inefficient SIMD width for Power 10",
                            "Inefficient SIMD width for AMD Ryzen",
                            "Improper value for one parameter",
                            "Improper parameter values for Power10",
                            "Improper parameter values for Power10",
                            "Improper parameter values for SKYLAKEX CPUs",
                        ],
                    },
                    "Use of slow instruction set": {"Count": 3},
                    "suboptimal API for the target architecture": {
                        "Count": 3,
                        "Sub-Sub-Sub-Category": "Improper value for greedy parameter",
                    },
                },
            },
        },
    },
    "Missing parallelism": {
        "Count": 12,
        "Percentage": 6.45,
        "Sub-Category": {
            "Vector/SIMD parallelism": {"Count": 5, "Percentage": 2.69},
            "GPU parallelism": {"Count": 2},
            "Instruction level parallelism": {"Count": 1},
            "Task parallelism": {"Count": 4},
        },
    },
    "Parallelization overhead/inefficiency": {
        "Count": 15,
        "Percentage": 8.06,
        "Sub-Category": {
            "small parallel region": {"Count": 5},
            "Inefficeint thread mapping / inefficient block size / Load imbalance": {
                "Count": 2
            },
            "inefficient thread mapping": {"Count": 1},
            "Under-parallelization": {"Count": 2},
            "Over-Parallelization": {"Count": 2},
        },
    },
    "Inefficient Concurrency control and synchronization": {
        "Count": 7,
        "Percentage": 3.76,
        "Sub-Category": {
            "Unncessary locks": {"Count": 3},
            "coarse-grain locks": {},
            "Unncessary strong memory consistency": {"Count": 1},
            "Lock management overhead": {"Count": 1},
            "Unnecessary synchronization": {"Count": 2},
        },
    },
    "Unnecessary process communication": {
"Count": 2,
},
"Inefficient algorithm /data-structure and their implementation": {
"Count": 73,
"Percentage": 39.25,
"Sub-Category": {
"Unnecessary operation/traversal/function call": {
"Count": 13,
"Percentage": 6.99,
"Sub-Sub-Category": {
"Unnecessary computation": {"Count": 2},
"Unnecessary function call": {"Count": 1},
"Inefficient sparse array computation": {"Count": 1},
"Unnecessary traversal": {
"Count": 8,
"Percentage": 4.3,
"Sub-Sub-Sub-Category": "unnecessary sort",
},
"Unnecessary itermediate variable usage": {"Count": 1},
},
},
"Redundant operation": {
"Count": 16,
"Percentage": 8.6,
"Sub-Sub-Category": {
"Redundant traversal": {"Count": 1},
"Redundant allocation": {"Count": 2},
"Redundant computation": {
"Count": 12,
"Percentage": 6.45,
"Sub-Sub-Sub-Category": [
"multtranspose in loop",
"Dead store",
"Redundant sort operation",
"Redundant variable assignment operation",
"Redundant list splitting due to integer overflow",
],
},
"Unnecessary branching (??)": {
"Count": 1,
"Sub-Sub-Sub-Category": "Removing branch in function (branch optimization)",
},
},
},
"Expensive operation": {
"Count": 29,
"Percentage": 15.59,
"Sub-Sub-Category": {
"Expensive algorithm": {"Count": 3},
"Expensive runtime evaluation": {"Count": 3},
"Expensive many memory references": {
"Count": 3,
"Sub-Sub-Sub-Category": "Expensive data-structure traversal",
},
"Expensive atomic call": {
"Count": 1,
"Sub-Sub-Sub-Category": "API miss use",
},
"Expensive computational kernel for a target architecture": {"Count": 3},
"expensive high precision calculation": {"Count": 3},
"Expensive exponential operation(O(n) overhead)": {"Count": 1},
"Expensive tensor calculation": {"Count": 1},
"Expensive type-casting": {"Count": 2},
"Expensive library function call": {"Count": 2},
"Expensive integer division": {"Count": 1},
"Expensive function call": {"Count": 5},
"Expensive kernel operation for small matrix": {"Count": 1},
},
},
"Frequent function call": {"Count": 3},
"Inefficient data-structure library": {
"Count": 9,
"Percentage": 4.84,
"Sub-Sub-Category": {
"Slower data structure": {"Count": 2},
"Inefficient library API call": {
"Count": 7,
"Sub-Sub-Sub-Category": [
"dynamic contiguous array allocation when size known statically",
"Inefficient due to reference counting overhead",
],
},
},
},
"Usage of improper data type": {
"Count": 3,
"Sub-Sub-Category": { 
"Slowdown due to wrong data type": {
"Count": 3,
"Sub-Sub-Sub-Category": "CUDA kernel performance degradation due to data type",
},
},
},
},
},
"Inefficient memory management": {
"Count": 13,
"Percentage": 6.99,
"Sub-Category": {
"memory leak": {"Count": 5},
"repreated memory allocation": {"Count": 4},
"Redundant memory allocation": {"Count": 1},
"Slower memory allocation library call": {"Count": 1},
"Insufficient memory": {
"Count": 1,
"Sub-Sub-Category": "Inefficiency while computing large multiplication due to lower memory size",
},
"unnecessary data copy": {"Count": 1},
},
},
"I/O inefficiency": {
"Count": 2,
"Sub-Category": {
"sequential I/O operation": {"Count": 1},
"over parallelization": {"Count": 1},
},
},
"Unintentional Programming logic error": {
"Count": 3,
"Sub-Category": {
"boundary condition check": {"Count": 2},
},
},
"Inefficiency due to new compiler version": {
"Count": 1,
},
}
