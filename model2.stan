data {
  int N;
  vector[N] As;
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
    mu[i] = alpha + beta * (As[i]);
  }
}

model {
  alpha ~ normal(6,2);
  beta ~ normal(0.5,0.3);
  sigma ~ normal(0,3);
  w ~ normal(mu, sigma);
}

generated quantities {
  real w_sim[GN];
  for (i in 1:GN) {
    w_sim[i] = normal_rng(alpha + beta*(gen[i]), sigma);
  }

  vector[N] log_likelihood;
  real y_hat[N];

  for (i in 1:N) {
    log_likelihood[i] = normal_lpdf(w[i] | As[i], sigma);
    y_hat[i] = normal_rng(mu[i], sigma);
  }
}
