# Dimensionality Reduction (PCA) Summer School — Study Guide

Welcome! This guide will introduce you to the motivation for dimensionality reduction and walk you through Principal Component Analysis (PCA) with intuitive explanations, simple Python examples, and hands-on exercises—all in one place.

---

## 📚 Pre-Study Resources

> **Please review these before you begin**  
> (You’ll build intuition and see step-by-step demos)

- [What is Dimensionality Reduction, and Why We Care (IBM)](https://www.ibm.com/think/topics/dimensionality-reduction)  
- [PCA Step by Step (YouTube)](https://www.youtube.com/watch?v=FgakZw6K1QQ&t=5s)  

---

## 🔍 Why Dimensionality Reduction?

### 1. The Curse of Dimensionality  
- **Data sparsity**: In high dimensions, points become far apart and notions of “closeness” break down.  
- **Overfitting risk**: Models can memorize noise instead of real patterns when you have too many features.  
- **Compute & storage**: More dimensions mean slower algorithms and heavier data handling.

### 2. What Does Dimensionality Reduction Solve?  
- **Simplifies data** by keeping only the most important features.  
- **Removes noise** and redundant information.  
- **Enables visualization** in 2D or 3D, helping you spot patterns.

### 3. Popular Techniques  
- **PCA (Principal Component Analysis)** — linear, variance-maximizing projection  
- **t-SNE** — non-linear, preserves local neighborhoods  
- **LDA (Linear Discriminant Analysis)** — supervised, maximizes class separation  
- **Autoencoders** — neural networks that learn compact representations  

---

## 📈 PCA at a Glance

1. **Center the data**  
   - Subtract the mean of each feature so data is zero-centered.

2. **Find principal directions**  
   - Compute the directions (principal components) along which the data varies most.

3. **Project onto top components**  
   - Choose the first *k* components and map your data onto that lower-dimensional space.

4. **Inspect explained variance**  
   - Each component explains a percentage of the total variance; check how many you need.

<img src="images/pca_schematic.png" alt="PCA schematic diagram" width="400"/>

---

## 🛠️ Python Example

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.decomposition import PCA

# Load Iris dataset
data = load_iris()
X, y = data.data, data.target

# PCA projection to 2D
pca = PCA(n_components=2)
Z = pca.fit_transform(X)

# Plot
plt.scatter(Z[:,0], Z[:,1], c=y, edgecolor='k')
plt.xlabel("PC1")
plt.ylabel("PC2")
plt.title("Iris in PCA space")
plt.show()

# How much variance did we keep?
print("Explained variance ratios:", pca.explained_variance_ratio_)

