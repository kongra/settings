{:user
 {:plugins      [[lein-pprint        "1.1.2"]
                 [lein-ancient      "0.6.10"]
                 [lein-bikeshed      "0.3.0"]
                 [jonase/eastwood    "0.2.3"]
                 [lein-kibit         "0.1.2" :exclusions [org.clojure/clojure]]

                 [cider/cider-nrepl "0.13.0"]]

  :signing      {:gpg-key "D7B06D3D"}

  :dependencies [[criterium           "0.4.4"]]

  :jvm-opts     ["-server"
                 "-d64"
                 "-Dclojure.compiler.direct-linking=true"

                 "-Xshare:off"
                 "-XX:+AggressiveOpts"
                 "-XX:+DoEscapeAnalysis"
                 "-XX:+UseCompressedOops"
                 ;; "-XX:+UseNUMA" ;; to check: numactl --hardware

                 "-Xms1G"
                 "-Xmx1G"

                 "-XX:+UseParallelGC"
                 "-XX:+UseParallelOldGC"
                 "-XX:NewSize=400m"
                 "-XX:MaxNewSize=400m"
                 "-XX:-UseAdaptiveSizePolicy"
                 "-XX:SurvivorRatio=6"

                 "-XX:+PrintGCDetails"
                 "-XX:+PrintGCTimeStamps"]}}
