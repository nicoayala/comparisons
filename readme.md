# Ruby JSON:API serialization performance comparisons

An automated suite of tests to explore the performance of the JSON:API
serialization implementations in Ruby.

The frameworks selection requirements:
 * maintained (recent releases, activity in PRs or issues)
 * have some popularity (send PRs if you still want it here)
 * be a library (we're not testing web frameworks here)

To start the benchmarks, run:

```
$ docker run --rm -v `pwd`:/app -w /app -it -e RUBYOPT=-W:no-deprecated ruby:2.7-alpine sh -c 'apk add git build-base && bundle && benchmark-driver ./all.yml --bundler'
```

## without docker

1. Clone
2. Run: `$ bundle install`
3. Then: `$ benchmark-driver ./all.yml --bundler`

To run ams to_json comparison: `$ benchmark-driver ./to_json.yml --bundler`

## Results

```
Warming up --------------------------------------
                using_oj(deep)      1.834 i/s -       3.000 times in 1.635719s (545.24ms/i)
              using_yajl(deep)      1.170 i/s -       2.000 times in 1.709323s (854.66ms/i)
active_model_serializers(deep)      1.724 i/s -       2.000 times in 1.160418s (580.21ms/i)
Calculating -------------------------------------
                using_oj(deep)      1.464 i/s -       5.000 times in 3.414280s (682.86ms/i)
              using_yajl(deep)      3.801 i/s -       3.000 times in 0.789280s (263.09ms/i)
active_model_serializers(deep)      1.269 i/s -       5.000 times in 3.941286s (788.26ms/i)

Comparison:
              using_yajl(deep):         3.8 i/s
                using_oj(deep):         1.5 i/s - 2.60x  slower
active_model_serializers(deep):         1.3 i/s - 3.00x  slower
```

active_model_serializers is 1-3x slower than the yajl version across all runs.
