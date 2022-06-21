data {
  int N;
  real Fs[N];
}

generated quantities {
  real<lower = 0> alpha=normal_rng(6,1.5);
  real beta = normal_rng(0.5,0.3);
  real<lower = 0> sigma = normal_rng(0,3);

  real y_sim[N];
  for (k in 1:N) {
    y_sim[k] = normal_rng(beta*Fs[N]+alpha,sigma);
  }
}
