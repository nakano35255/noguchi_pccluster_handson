# ログイン方法

野口研究室は３つの計算機サーバーを持っている。
それぞれ以下のIPアドレスとが割り当てられている。

- **nok00.issp.u-tokyo.ac.jp**
  - IPアドレス: 192.168.93.166
- **nog00.issp.u-tokyo.ac.jp**
  - IPアドレス: 192.168.93.196
- **nox00.issp.u-tokyo.ac.jp**
  - IPアドレス: 192.168.93.202

`nox00`は古い計算機なので基本的に用いず、`nok00`と`nog00`を用いること。
特にpythonユーザーは`nok00`を使用する（pythonが完備されているため）。


## 物性研内からログイン

物性研内部のネットワークに入っている場合、terminalから以下のコマンドを実行することで、それぞれのサーバーにログインできる。

```sh
ssh username@192.168.93.166
```
usernameは登録したユーザー名であり、IPアドレス部分はログインしたいサーバーごとに変更する。

上記のコマンドを打つと、以下のようにパスワードが求められるので登録済みのパスワードを入力する。

```sh
ssh username@192.168.93.166
username@192.168.93.166's password: 
Last login: Wed Jul 10 12:43:40 2024 from 192.168.00.000
[username@nok00 ~]$ 
```
するとログインできる。


## 物性研外からログイン

物性研外のネットワークから野口研PCクラスタを使用したい場合、一度物性研ログインサーバーに入り、そこを踏み台にして野口研PCクラスタのログインするという二段階の手続きが必要となる。

物性研ログインサーバーを使用するための事前準備については[物性研ログインサーバーを使うための準備](./issp/issp.md)に詳しく解説している。

事前準備が完了しているなら、以下の手順で野口研PCクラスタにログインできる。

最初に、terminalに以下のコマンドを打ち込み、物性研ログインサーバーに入る。

```sh
ssh username@login.issp.u-tokyo.ac.jp
```

usernameは物性研のメールアドレス`@issp.u-tokyo.ac.jp`の前の部分である。
正しくコマンドを打ち込めていれば、以下のようにパスワードを求められる。

```sh
```

正しくパスワードを打ち込むことで、以下のようにログインできる。

```sh
========================================================================

In this server,
Files larger than 10KB that you make in your home directory will be deleted in two days.
Please be sure to make a backup of your file on your local computer.

Computer Center

========================================================================

Last login: Thu Aug  7 21:06:00 2025 from 133.201.137.128
/usr/bin/id: グループ ID 1027 のグループ名がみつかりません
[username@isspns-login ~]$ 
```

「/usr/bin/id: グループ ID 1027 のグループ名がみつかりません」とコメントが出るが、普通に使えているので問題なさそう。

これで、物性研ログインサーバーに入れたので、次のここから野口研PCクラスタにログインする。
例えば、`nok00`に入りたいときには、以下のようにterminalのコマンドを打ち込む。

```sh
[username@isspns-login ~]$ ssh username@192.168.93.166
```

ここの`username`は野口研PCクラスタのユーザー名であることに注意。

このコマンドを正しく打てていれば、以下のようにパスワードを求められ、野口研PCクラスタにログインすることができる。

```sh
[username@isspns-login ~]$ ssh username@192.168.93.166
username@192.168.93.166's password: 
Last login: Thu Aug  7 11:58:41 2025 from 192.168.130.45
[username@nok00 ~]$ 
```
