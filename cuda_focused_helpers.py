import pandas as pd

def cuda_commit_link_extracter(path_to_links = "Data\\RQ1\\cuda_links.txt"):
    cuda_links = []
    with open("Data\\RQ1\\typedlinks.txt", 'r') as f:
        #read every line in the file
        for line in f:
            split = line.split()
            if len(split) ==2 and split[1].lower() == "cuda":
                cuda_links.append(split[0])

    with open(path_to_links, 'w') as f:
        for link in cuda_links:
            f.write(link + "\n")       

#cuda_commit_link_extracter()
    