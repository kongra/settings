{:user {:plugins [[lein-pprint        "1.2.0"]
                  [lein-ancient      "0.6.15"]
                  [lein-bikeshed      "0.5.1"]
                  [jonase/eastwood    "0.3.4"]
                  [lein-kibit         "0.1.6"
                   :exclusions
                   [org.clojure/tools.namespace
                    org.clojure/tools.cli]]]

        :signing      {:gpg-key   "CF1B5B02"}
        :dependencies [[criterium    "0.4.4"]]}
 }
