# Pythonのジョブ投入

Pythonで書かれたプログラムの投げ方を説明する。

最初にテスト用のコードを書こう。
```sh
mkdir handson
cd handson
```
として、handsonフォルダに移動する。そして、
```sh
vim test.py
```
でtest.pyを開き、以下を書き込む。
```sh
import numpy as np
import os
import math
import random
from multiprocessing import Pool, cpu_count
from scipy import stats
import sys


if __name__ == '__main__':
    print("Hello World!")

```

Pythonではコンパイルは不要であるので、このコードをそのまま投げる。

PCクラスタやスパコンのような共有計算資源では、プログラムをジョブスクリプトを用いて計算機に投げ、順番待ちをする。この順番待ちの列を「キュー（Queue）」と呼ぶ。
ジョブスクリプトは特殊なコメント欄を持つシェルスクリプトで、ジョブスケジューラに対してどのような計算資源を要求するかやどのようにプログラムを実行するかの指示を与える。
このような、あらかじめ定義された一連の処理を一括して実行するジョブのことを「バッチジョブ（Batch job）」と呼ぶ。

実際にジョブスクリプトを書いてみる。
```sh
vim test.sh
```
を入力しtest.shを開き、以下を書き込む。
```sh
#!/bin/bash

#SBATCH -p nok
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1

python3 ./test.py &

wait
```

最初の`#!`で始まる行はシバン(shebang)と呼ばれ、このスクリプトを処理するシェルを指定する。

次行からの`#SBATCH`で始まる行が、ジョブスケジューラ(Slurm)への指示である。それぞれの意味は以下の通り。

* `-p defq` 計算資源(パーティション)の指定で、ここでは`defq`を指定している。（nog00では、基本的に`defq`を用いれば良く、nok00では`nok`を用いれば良い。）
* `-N 1` 要求ノード数(ここでは1ノード、基本的に1ノードで良い。)
* `-n 1` 利用プロセス数(ここでは1プロセス、mpi並列を用いた並列化を行わない限り1プロセスで良い。)
* `-c 1` 利用スレッド数(ここでは1スレッド、openmpを用いた並列化を行わない限り1スレッドで良い。)

最後の行でpythonの実行したいジョブのコマンドラインを書き込む。

このシェルスクリプトをジョブとして投入するには`sbatch`コマンドを使う。

```sh
sbatch -w nok00 test.sh
```

ここで、現状python環境が完備されているのはnok00だけなので、`-w nok00`によって計算がnok00にだけ投げられるように指定しておく。

ジョブを投入した結果、ジョブIDが割り振られる。ジョブの状態は`squeue`コマンドで知ることができる。

```sh
squeue
```

例えば以下のような表示がでる。

```txt
            JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            21122       nok    test.sh  nakano R       0:03      1 nok00
```

それぞれの情報の意味は以下の通り。

* ジョブID(JOBID)として21122が割り振られた
* 計算リソース(PARTITION)は`nok`を要求している
* シェルスクリプトのファイル名(NAME)は`test.sh`である
* 状態(status, ST)は実行中(R)である
* 実行開始からの時間(TIME)は3秒(0:03)
* 要求ノード数(NODES)は1である
* 実行ノードリスト(NODELIST)、もしくは待ち状態ならその理由(REASON)

間違ったジョブを投入してしまった場合は
```sh
scancel JOBID
```
でジョブを削除する。上の場合は
```sh
scancel 21122
```
となる。

計算が終了すると、slurm-21122.outのようなファイル名のファイルが生成されている。
```sh
ls
out.exe  slurm-21122.out  test.c  test.sh
```
slurm-21122.outの中に
```sh
Hello World!!
```
と書かれていれば、正常に計算が実行されたことになる。


## PCクラスタからデータをダウンロード/アップロードする

`scp` (secure copy) コマンドを使用すると、自身のPC（ローカル）とPCクラスタ（リモート）との間で、ファイルをコピー（ダウンロード/アップロード）することができる。

`scp`コマンドは、基本的に以下の書式で使用する。
```sh
scp [オプション] [コピー元のパス] [コピー先のパス]
```

例えば、PCクラスタ（IPアドレス: `192.168.93.166`）の `/home/username/test/` ディレクトリにある `result.data` というファイルを、現在作業しているディレクトリ（`./`）にダウンロードする場合、以下のコマンドを実行すればよい。

```sh
scp username@192.168.93.166:/home/username/test/result.data ./
```
なお、現在いる場所は
```sh
pwd
```
を使えばわかる。

逆に、自分のPCにある `result.data` というファイルを、PCクラスタの `/home/username/test/` ディレクトリにアップロードする場合、以下のコマンドを実行する。
```sh
scp result.data username@192.168.93.166:/home/username/test/
```
とすれば良い。

自分のPCにある test ディレクトリを丸ごと、PCクラスタの /home/username/ ディレクトリ配下にアップロードします。
```sh
scp -r test username@192.168.93.166:/home/username/
```
のように`-r`オプションを追加しなくてはいけない。



