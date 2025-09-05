// Hjälpfunktioner för statistik & normalitet (utan tunga beroenden)

export function pearson(x, y) {
  return ss.sampleCorrelation(x, y);
}

export function spearman(x, y) {
  return ss.spearmansRankCorrelation(x, y);
}

export function skewness(arr) {
  return ss.sampleSkewness(arr);
}

export function excessKurtosis(arr) {
  return ss.sampleKurtosis(arr); // redan excess (0 för normal)
}

export function quantiles(arr, probs) {
  const sorted = [...arr].sort((a, b) => a - b);
  return probs.map(p => ss.quantileSorted(sorted, p));
}
