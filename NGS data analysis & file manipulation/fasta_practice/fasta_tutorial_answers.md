# Answers to FASTA and FASTQ Exercises

---

## FASTA Practice Answers

### **EXERCISE 1**  
**Answer:**  
```bash
head -n 20 sample2_100.fasta
```

### **EXERCISE 2**  
**Answer:**  
```bash
grep -c "^>" sample2_100.fasta
```

### **EXERCISE 3**  
**Answer:**  
```bash
grep -B1 "GATTACA" sample2_100.fasta | grep "^>"
```

### **EXERCISE 4**  
**Answer:**  
```bash
grep -A1 "^>read42" sample2_100.fasta
```

### **EXERCISE 5**  
**Answer:**  
```bash
grep "^>" sample2_100.fasta
```

### **EXERCISE 6**  
**Answer:**  
```bash
grep -v "^>" sample2_100.fasta | tr -d "\n" | wc -c
```

### **EXERCISE 7**  
**Answer:**  
```bash
grep "^>" sample2_100.fasta | sort
```

### **EXERCISE 8**  
**Answer:**  
```bash
awk '/^>/ {if (seq) {print length(seq); seq=""} printf "%s\t", $0; next} {seq=seq$0} END {print length(seq)}' sample2_100.fasta
```

---

## FASTQ Practice Answers

### **EXERCISE 9**  
**Answer:**  
```bash
head -n 40 sample_100.fq
```

### **EXERCISE 10**  
**Answer:**  
```bash
wc -l sample_100.fq | awk '{print $1/4}'
```

### **EXERCISE 11**  
**Answer:**  
```bash
awk 'NR % 4 == 1 {header=$0} NR % 4 == 2 && /GATTACA/ {print header}' sample_100.fq
```

### **EXERCISE 12**  
**Answer:**  
```bash
grep -A3 "^@read42" sample_100.fq
```
