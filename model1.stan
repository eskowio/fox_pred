data {
  int N;
  vector[N] Gs;
  real w[N];

  int GN;
  vector[GN] gen;
}

parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  for (i in 1:N) {
    mu[i] = alpha + beta * (Gs[i]);
  }
}

model {
  alpha ~ normal(6,2);
  beta ~ normal(-0.3,0.2);
  sigma ~ normal(0,3);
  w ~ normal(mu, sigma);
}

generated quantities {
  vector[N] log_likelihood;
  real y_hat[N];

  for (i in 1:N) {
    log_likelihood[i] = normal_lpdf(w[i] | Gs[i], sigma);
    y_hat[i] = normal_rng(mu[i], sigma);
  }

  real w_sim[GN];
  for (i in 1:GN) {
    w_sim[i] = normal_rng(alpha + beta*(gen[i]), sigma);
  }

}
