# tmux+vimの設定例
###### tags: `admin`

## 0. まえがき

本調査にあたり、パッケージマネージャ`apt`,`brew`のデフォルトの設定でインストールした環境でテストを行った。その際の詳しいバージョン情報を以下に示す。
| OS | tmux | vim | python |
|-|-|-|-|
| Ubuntu20.04 | 3.0a | 8.1 | 3.8.5 |
| MacOS10.13.6 | 3.2a | 8.0 | 3.7.7 |


## 1. プログラミングフォント`HackGenNerd`のインストール

### なぜプログラミングフォントを使うのか？
後述する[powerline](https://github.com/powerline/powerline)という、ステータスバーにホストの詳細な情報を表示する非常に便利なプラグインが存在します。これは`tmux`,`vim`,`ipython`,`bash`,`zsh`…に対応しています。
少ない面積に多くの情報を表示するため、アイコンや情報のセパレータに特殊なグリフを用いています。これらのグリフは[nerd-fonts](https://github.com/ryanoasis/nerd-fonts)を用いることで表示ができますが、開発者の多くは英語圏であるため、日本語も綺麗に表示できるプログラミングフォントというものはこれまで存在してきませんでした。

こうした課題を受け、フォント作者である[俵氏](https://twitter.com/tawara_san)がこの`HackGenNerd`を作成しました。このプログラミングフォントを使うと以下のような利点があります。

- 日本語が非常に美しく表示される。
- Powerline Symbols, Font Aesome等のグリフにすべて対応している
- ヒンティングが付与され、アイコン等が正しい幅で表示される
- ライセンスが緩く、改変及び配布が自由で、可搬性がある
- 【採用実績】技能五輪ユース大会 業務用ITソフトウェア・ソリューションズ部 指定フォント


気の遠くなるような地道な作業が作者による記事にまとめられています。
[Ricty を神フォントだと崇める僕が、フリーライセンスのプログラミングフォント「白源」を作った話](https://qiita.com/tawara_/items/374f3ca0a386fab8b305)

↓`HackGenNerd`が対応する特殊なグリフの一覧
![](https://i.imgur.com/eqCwoMg.png)


### `HackGenNerd`インストール手順
[**＞＞リリースページ＜＜**](https://github.com/yuru7/HackGen/releases/tag/v2.3.5)
からHackGen**Nerd**フォントのzipファイルをダウンロード・解凍し、
`HackGenNerd-Regular.ttf`をダブルクリックしてインストールしてください。
このようにTrueTypeFont`拡張子.ttf`形式で配布されているため、OSに依らず、可搬性があります。
![](https://i.imgur.com/iYyhFhk.png)

インストールが完了したら、ターミナルやエディタのフォントをすべて`HackGenNerd`に変更してください。

#### Mac、Windowsの場合
![](https://i.imgur.com/NGZn7Hz.png)
<!--
#### Windowsの場合
![](https://i.imgur.com/QLgI3na.png)
![](https://i.imgur.com/hWlSvfB.png)
-->

#### VSCodeの場合
![](https://i.imgur.com/B9hwn3f.png)


## 2. [powerline](https://github.com/powerline/powerline)のインストール


前述しましたが[powerline](https://github.com/powerline/powerline)という、ステータスバーにホストの詳細な情報を表示する非常に便利なプラグインが存在します。これは`tmux`,`vim`,`ipython`,`bash`,`zsh`…に対応しています。

さて、この文章を読んでいる方は`python`のヘビーユーザかと思います。その場合、`venv`,`vertualenv`,`pyenv`,`anaconda`など様々な仮想環境内で作業しているかと思います。[powerline](https://github.com/powerline/powerline)自体は`pip install powerline-status`で入るのですが、仮想環境を跨いだら`tmux`のpowerlineが表示されなくなった…などといった事態は起こしたくないわけであります。

こうした課題を受け、**.tmux.rcではスクリプト・インタプリタを絶対パスを指定する**という方針でこの問題を解決することとします。

参考文献: https://powerline.readthedocs.io/en/latest/installation.html
### 固定した場所へ[powerline](https://github.com/powerline/powerline)のインストール

[powerline](https://github.com/powerline/powerline)が確実に動作するためには絶対パスが指定されることが要であり、Pythonインタプリタは任意の場所でも大丈夫なのですが、今回は具体例として、
```
sudo apt install python3 python3-pip
```
で入るsystemの`/usr/bin/python3`を使った場合を紹介します。
そのほかの場所のインタプリタをお使いの方はこの文字列が登場したら自分の環境のものに読み替えてください。例えば、Macをお使いの場合は`/usr/local/bin/python3`に読み替えてください。


まずは[powerline](https://github.com/powerline/powerline)リポジトリをホームディレクトリ下にクローンします。
```
git clone https://github.com/powerline/powerline $HOME/powerline
```

次に`--editable`オプションを指定してこのリポジトリをライブラリとしてインストールしましょう。

```
/usr/bin/python3 -m pip install --editable=$HOME/powerline
```

このようなインストール方法が初めての方は戸惑うかと思いますが、次のような出力が得られればインストールは成功しています。
```
Obtaining file:///$HOME/powerline
Installing collected packages: powerline-status
  Running setup.py develop for powerline-status
Successfully installed powerline-status
```

ここまで完了したら、`powerline`ライブラリを実際にimportできるか、チェックしましょう。設定のエントリポイントである`powerline-config`スクリプトが内部でimportしているため、この確認は重要です。
```
/usr/bin/python3 -c "import powerline; print(powerline.__file__)"
```

これで、以下のような表示が得られれば準備は完成です。
```
$HOME/powerline/powerline/__init__.py
```

さて、なぜわざわざ`--editable`オプションを使用してローカルからインストールしたかといいますと、次のスクリプト群を確実に絶対パスで指定したいためです。
```
ls $HOME/powerline/scripts
```

これで、（全体像は後述しますが）`.tmux.conf`に次の1行を書き込むことでステータスバーに[powerline](https://github.com/powerline/powerline)を有効化することが出来ました。

```
run-shell "/usr/bin/python3 $HOME/powerline/scripts/powerline-config tmux setup"
```

## 3. tmuxの設定

`<prefix>+S`で平行分割など、なるべく`screen`にキーバインドを寄せてあります。
`tmux`独自の機能である、分割したすべてのペインに同時に同じコマンドを送る`synchronized-pane`をトグルするキーバインドを`<prefix>+t`にバインドするなど、Out Of Boxな設定をしてあります。詳しい内容は`.tmux.conf`のコメントをご覧ください。
```tmux=
# -*- coding: utf-8 -*-
# tmux内で動くTUIプログラムに256諧調表示が可能であることを伝える設定。
# vimはこの設定を検知してtmuxの中でもset-option termguicolorsが使えるようになる。
set-option -g default-terminal xterm-256color
set-window-option -g xterm-keys on
# 詳しい説明は https://qiita.com/yami_beta/items/ef535d3458addd2e8fbb
set-option -ag terminal-overrides ",*256col*:colors=256:Tc"

### screen互換の設定 ###
# <prefix>をctrl-bからctrl-tに変更
unbind-key C-b
set-option -g prefix C-t
bind-key C-t send-prefix
# <prefix>+Sで水平分割
bind-key S split-window -h
# <prefix>+|で垂直分割は同じなので設定なし

### vimライクな操作の設定 ###
# <prefix>+[でコピーモードに入って
# spaceで選択開始、enterで選択終了
# <prefix>+]で貼り付け
set-window-option -g mode-keys vi
# <prefix>+hjklで画面選択
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
# vimがマウスを解釈するのでtmuxはパススルー
# onにするとマウス操作選択でコピーができる
set -g mouse off
# <prefix>+[でコピーモードに入って
# C-u, C-dで履歴をさかのぼれる最大数
set-option -g history-limit 999999999

# <prefix>+rで設定ファイルリロード
bind-key r source-file ~/.tmux.conf \; display "Reloaded"
# <prefix>+tで分割したpaneにコマンド同時送信を切り替える
bind-key t setw synchronize-panes \; display "synchronize-panes #{?pane_synchronized,on,off}"

# <prefix>+qで複数分割したペインのどれにジャンプするか数字で選択する
set-option -g display-panes-time 2147483647
# 0は押しにくいのでウィンドウ/ペインの開始番号を1からにする
set-option -g base-index 1
set-window-option -g pane-base-index 1

# メッセージスタイルをpowerlineと合わせる
set-option -g message-command-style bg=black,fg=cyan
set-option -g message-style         bg=black,fg=cyan

# うるさいベルをなくす
set-option -g bell-action none

# 次の2行はターミナルをリサイズしたときに分割幅を追従させる
set-option -g focus-events on
set-window-option -g aggressive-resize on

# chshで変えられない場合、tmuxで使うシェルはここで変えられる
#set-option -g default-shell /bin/zsh

# ステータスバーにpowerlineを有効化する
run-shell "/usr/bin/python3 $HOME/powerline/scripts/powerline-config tmux setup"
```

## 4. vimの設定
### vimプラグインマネージャ[vim-plug](https://github.com/junegunn/vim-plug)のインストール

UbuntuやMacなどの\*nixな環境をお使いの場合は以下のコマンドで一発で入ります。
具体的には、`plug.vim`という単一ファイルだけで動くようになっており、それを、`~/.vim/autoload/`という起動時に自動的に読み込まれるディレクトリに配置しています。

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### `.vimrc`の設定
上記の[vim-plug](https://github.com/junegunn/vim-plug)をインストールしたことをうけ、非常に短い`.vimrc`への記述で外部プラグインを読み込むことが可能になりました。


```vim=
" -*- coding: utf-8 -*-
set encoding=utf-8 " このvimrcのエンコーディング
set number
set cursorline

" plug#begin から plug#end の間で Plug 'repo/name' で指定したものが
" .vimrcを読み込みなおして :PlugInstall でインストールできる
call plug#begin('~/.vim/plugged')

" $HOME/powerline からvimの設定を読み込む
Plug '~/powerline/powerline/bindings/vim'
set laststatus=2 " ステータスバーを常に表示する
set showtabline=2 "タブバーを常に表示する

Plug 'tomasr/molokai'

Plug 'jpalardy/vim-slime'
" 自前でキーマッピングする
let g:slime_no_mappings = 1
" 始点からVで選択モードに入ってjjj…と降りてきて終点に辿り着いた時点で
" 右人差し指はjに置いてある筈なので<C-j>にマップする
" ノーマルモードで<C-j>を押した場合、現在行前後のパラグラフが送られる
xmap <C-j> <Plug>SlimeRegionSend
nmap <C-j> <Plug>SlimeParagraphSend
let g:slime_target = "tmux"
" 現在は<prefix>+qで表示されるpane番号が2番のpaneにテキストが送られるように設定されているが、
" {right-of} を指定して、現在ペインの右側に送る設定や
" {marked} を指定して<prefix>+mでマークした(枠の色が変わる)ペインに送るように設定を変更できる。
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
" ipython向けに ヘッダーを%cpaste -q, フッターを--にする
let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1

call plug#end()

" vimrcの最後にすべき設定
filetype plugin indent on
set t_Co=256
syntax on
set termguicolors
silent! colorscheme molokai

```

`.vimrc`を書き換えた後、`vim`を起動し、`:PlugInstall`コマンドを実行することで、記述したプラグインのインストールが行われます。`vim`を再起動すると反映されます。

## 5. 実際に動いている様子

![](https://i.imgur.com/0FfdEJ2.gif)

--- 

以上で設定は終わりです。お疲れさまでした。
今回の設定ファイルは [minimal_tmux_vim](https://github.com/nat-chan/minimal_tmux_vim) に置いておきます。直接DLしたい方はここからどうぞ。何かあればTwitter:@mathbbN まで。
それでは、

**Happy Vim Life🎉** 

---


## 以下、雑記

### iPythonもpowerlineする

https://powerline.readthedocs.io/en/master/usage/other.html#ipython-prompt

を参考に

`~/.ipython/profile_default/ipython_config.py`に

```
c = get_config()
c.InteractiveShellApp.extensions = [
    'powerline.bindings.ipython.post_0_11'
]
```

を書くとiPythonまでpowerlineになりました。

### デーモンの立ち上げ

先に以下のコマンドでデーモンを立ち上げておくと`tmux`等のStatupTimeが高速化したように感じます。（未計測）

```
/usr/bin/python3 $HOME/powerline/scripts/powerline-daemon -q
```

### シェル

`.bashrc`に
```
. $HOME/powerline/powerline/bindings/bash/powerline.sh
```

`.zshrc`に
```
. $HOME/powerline/powerline/bindings/zsh/powerline.zsh
```

追記するとプロンプトまでpowerlineになるらしい。
vimはairline、shellはpowerlevel10kを使っていたけどそろえるのもアリかも。
