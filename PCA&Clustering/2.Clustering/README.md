# Bioinformatics Clustering Summer School — Self-Study Guide

Welcome to the Bioinformatics Clustering Summer School! This self-study guide will walk you through the fundamentals of clustering algorithms, provide hands-on Python examples, and point you to further resources. Before diving into the tutorials, **please review the following resources** in order to build the necessary intuition.

---

## 📚 Pre-Study Resources

> **Watch and read these before you begin**:

- [YouTube video: Intuitive intro to unsupervised ML and clustering](https://www.youtube.com/watch?v=IUn8k5zSI6g)  
- [YouTube video: K-means](https://www.youtube.com/watch?v=4b5d3muPQmA&t=304s)  
- [YouTube video: Hierarchy](https://www.youtube.com/watch?v=7xHsRkOdVwo)  
- [YouTube video: DBSCAN (advanced)](https://www.youtube.com/watch?v=RDZUdRSDOok)  
- [scikit-learn Documentation on Clustering](https://scikit-learn.org/stable/modules/clustering.html)  
- [Cluster analysis (hardcore math)](https://en.wikipedia.org/wiki/Cluster_analysis)  
- [Blogpost on the Math of clustering](https://medium.com/@rohit_batra/the-math-behind-the-k-means-and-hierarchical-clustering-algorithm-1d9a36a56c08)  

---

## 🔍 Clustering Algorithm Overviews

### 1. K-means

<img src="images/kmeans_diagram.png" alt="K-means illustration" width="400"/>

1. **Initialize** K centroids randomly.  
2. **Assign** each point to the nearest centroid.  
3. **Update** centroids by computing the mean of assigned points.  
4. **Repeat** steps 2–3 until convergence (assignments no longer change).

---

### 2. Hierarchical (Agglomerative)

<img src="images/hierarchical_diagram.png" alt="Hierarchical clustering dendrogram" width="400"/>

- **Start**: Each point is its own cluster.  
- **Merge**: At each step, join the two clusters with the smallest distance (single-link, complete-link, or average-link).  
- **End**: Continue until all points form one cluster; cut the tree at desired level.

---

### 3. DBSCAN

<img src="images/dbscan_diagram.png" alt="DBSCAN core/border/noise points" width="400"/>

- **Parameters**: ε (neighborhood radius) and MinPts (minimum points to form a cluster).  
- **Core points**: ≥ MinPts within ε.  
- **Border points**: < MinPts within ε but in neighborhood of a core point.  
- **Noise**: Neither core nor border.  
- **Process**:  
  1. Pick unvisited point.  
  2. If it’s a core point, start a new cluster and recursively collect all density-connected points.  
  3. Otherwise mark as noise (might be border later).

---

## 🛠️ Python Code Examples

All examples use **scikit-learn** and **matplotlib**.

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import make_blobs, make_moons
from sklearn.cluster import KMeans, AgglomerativeClustering, DBSCAN

# Generate sample data
X1, _ = make_blobs(n_samples=300, centers=4, random_state=42)
X2, _ = make_moons(n_samples=300, noise=0.05, random_state=42)

# 1. K-means
km = KMeans(n_clusters=4, random_state=42)
labels_km = km.fit_predict(X1)

plt.scatter(X1[:, 0], X1[:, 1], c=labels_km)
plt.title("K-means Clustering")
plt.show()

# 2. Hierarchical
hc = AgglomerativeClustering(n_clusters=2, linkage='average')
labels_hc = hc.fit_predict(X2)

plt.scatter(X2[:, 0], X2[:, 1], c=labels_hc)
plt.title("Hierarchical Clustering (Average Link)")
plt.show()

# 3. DBSCAN
db = DBSCAN(eps=0.2, min_samples=5)
labels_db = db.fit_predict(X2)

plt.scatter(X2[:, 0], X2[:, 1], c=labels_db)
plt.title("DBSCAN Clustering")
plt.show()

