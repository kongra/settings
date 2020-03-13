{:user {:plugins [[lein-pprint        "1.3.2"]
                  [lein-ancient      "0.6.15"]
                  [lein-bikeshed      "0.5.2"]
                  [jonase/eastwood   "0.3.10"]
                  [lein-kibit         "0.1.8" :exclusions [org.clojure/tools.namespace]]]

        :signing      {:gpg-key   "CF1B5B02"}
        :dependencies [[criterium    "0.4.5"]
                       [clj-kondo  "RELEASE"]]
        :aliases      {"clj-kondo" ["run" "-m" "clj-kondo.main"]}}}
