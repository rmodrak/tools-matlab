function x = myeps(X)

x = eps(0.5 * (max(X(:)) - min(X(:))))^(1/3);
