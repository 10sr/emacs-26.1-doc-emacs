# 使い方
# 	html(単一、複数)、infoを作成する場合は、make
# 	全部(pdf、txt、tarを含む)を作成する場合は、make && make pdf && make txt && make tar

# 必要なもの
#
# po4a(https://po4a.alioth.debian.org/index.php.ja)が必要です
# 理由:	翻訳前のtexiとpoファイルから翻訳済みのtexiを生成するため
#
# texinfo(https://www.gnu.org/software/texinfo/)が必要です
# 理由:	texiファイルからhtml、infoを生成するため
#
# tar(https://www.gnu.org/software/tar/)が必要です(オプション)
# 理由:		texiファイルをアーカイブするため
# コンパイル:	makeの後にmake tar
#
# texlive(http://www.tug.org/texlive/)が必要です(オプション)
# 理由:		texiファイルから日本語PDFを作成するため
# コンパイル:	makeの後にmake pdf
# 注意:		使用したTexLiveはTexLive2015です。
#		2016/09時点のTexLive2016ではエラーにより作成できませんでした

.PHONY: clean

# デフォルトは単一html、分割html、info
all: single-html multi-html info

# 単一html用のターゲット
single-html: emacs-ja.html

# 分割html用のターゲット
# html/*.htmlが生成されます
multi-html: html/index.html

# info用のターゲット
info: emacs-ja.info

# ASCII text用のターゲット
txt: emacs-ja.txt

# pdf用のターゲット(オプション)
pdf: emacs-ja.pdf emacs-xtra-ja.pdf

# tar.gz用のターゲット(オプション)
tar: emacs-ja.texis.tar.gz

TEXIS := \
abbrevs.texi \
ack.texi \
anti.texi \
arevert-xtra.texi \
basic.texi \
buffers.texi \
building.texi \
cal-xtra.texi \
calendar.texi \
cmdargs.texi \
commands.texi \
custom.texi \
dired-xtra.texi \
dired.texi \
display.texi \
doclicense.texi \
docstyle.texi \
emacs-xtra.texi \
emacs.texi \
emacsver.texi \
emerge-xtra.texi \
entering.texi \
files.texi \
fixit.texi \
fortran-xtra.texi \
frames.texi \
glossary.texi \
gnu.texi \
gpl.texi \
help.texi \
indent.texi \
killing.texi \
kmacro.texi \
m-x.texi \
macos.texi \
maintaining.texi \
mark.texi \
mini.texi \
misc.texi \
modes.texi \
msdos-xtra.texi \
msdos.texi \
mule.texi \
package.texi \
picture-xtra.texi \
programs.texi \
regs.texi \
rmail.texi \
screen.texi \
search.texi \
sending.texi \
text.texi \
trouble.texi \
vc-xtra.texi \
vc1-xtra.texi \
windows.texi \
xresources.texi

JA_SUFFIX := "-ja"

clean:
	rm -f *.texi
	rm -f *.html
	rm -fR html/
	rm -f *.info
	rm -f *.pdf
	rm -f *.txt
	rm -f *.tar.gz
	rm -fR emacs.texis/

%.texi:
	if [ -f $@.po ]; \
	then \
		JA_TEXI=$$(printf "%s%s%s" $* ${JA_SUFFIX} .texi); \
		po4a-translate -f texinfo -k 0 -M utf8 -m original_texis/$@ -p $@.po -l $${JA_TEXI}; \
		case $${JA_TEXI} in \
		"emacs-ja.texi" ) perl -pe 's{\@setfilename \.\./\.\./info/emacs\.info}{\@setfilename emacs-ja.info}' -i emacs-ja.texi ;; \
		"emacs-xtra-ja.texi" ) perl -pe 's{\@setfilename \.\./\.\./info/emacs-xtra\.info}{\@setfilename emacs-xtra-ja.info}' -i emacs-xtra-ja.texi ;; \
		"screen-ja.texi" ) perl -pe 's/\@section Point$$/\@section ポイント/' -i screen-ja.texi ;; \
		"commands-ja.texi" ) perl -pe 's/\@section Keys$$/\@section キー/;'\
's/\@section Kinds of User Input$$/\@section ユーザー入力の種類/;'\
's/\@section Keys and Commands$$/\@section キーとコマンド/;'\
 -i commands-ja.texi ;; \
		"entering-ja.texi" ) perl -pe 's/\@section Entering Emacs$$/\@section Emacsの起動/;'\
's/\@section Exiting Emacs$$/\@section Emacsの終了/;'\
 -i entering-ja.texi ;; \
		"basic-ja.texi" ) perl -pe \
's/\@section Inserting Text/\@section テキストの挿入/;'\
's/\@section Blank Lines/\@section 空行/;'\
's/\@section Continuation Lines/\@section 継続行/;' -i basic-ja.texi ;; \
		"mini-ja.texi" ) perl -pe \
's/\@section Completion/\@section 補完/;'\
's/\@subsection Completion Example/\@subsection 補完の例/;'\
's/\@subsection Completion Commands/\@subsection 補完コマンド/;'\
's/\@subsection Completion Exit/\@subsection 補完の終了/;'\
's/\@subsection Completion Options/\@subsection 補完オプション/;'\
's/\@section Minibuffer History/\@section ミニバッファーヒストリー/;'\
's/\@section Yes or No Prompts/\@section Yes or No プロンプト/;' -i mini-ja.texi ;; \
		"help-ja.texi" ) perl -pe \
's/\@chapter Help$$/\@chapter ヘルプ/;'\
's/\@section Help Summary$$/\@section ヘルプの概要/;'\
's/\@section Apropos$$/\@section Apropos\(適切な\)/;'\
's/\@section Help Files$$/\@section ヘルプファイル/;' -i help-ja.texi ;; \
		"mark-ja.texi" ) perl -pe 's/\@section Shift Selection$$/\@section シフト選択/' -i mark-ja.texi ;; \
		"killing-ja.texi" ) perl -pe \
's/\@section Deletion and Killing$$/\@section 削除とkill/;'\
's/\@subsection Deletion$$/\@subsection 削除/;'\
's/\@subsection Killing by Lines$$/\@subsection 行のkill/;'\
's/\@subsection Other Kill Commands$$/\@subsection その他のkillコマンド/;'\
's/\@section Yanking$$/\@section yank/;'\
's/\@subsection Appending Kills$$/\@subsection killしたテキストの追加/;'\
's/\@subsection Secondary Selection$$/\@subsection セカンダリー選択/;'\
's/\@section Accumulating Text$$/\@section テキストの追加/;'\
's/\@section Rectangles$$/\@section 矩形領域(Rectangles)/;'\
's/\@section CUA Bindings$$/\@section CUAバインド/;' -i killing-ja.texi ;; \
		"regs-ja.texi" ) perl -pe \
's/\@chapter Registers$$/\@chapter レジスター/;'\
's/\@section Keyboard Macro Registers/\@section キーボードマクロのレジスター/;'\
's/\@section Bookmarks/\@section ブックマーク/;' -i regs-ja.texi ;; \
		"display-ja.texi" ) perl -pe \
's/\@section Scrolling$$/\@section スクロール/;'\
's/\@section Recentering$$/\@section センタリング/;'\
's/\@section Horizontal Scrolling$$/\@section 水平スクロール/;'\
's/\@section Narrowing$$/\@section ナローイング/;'\
's/\@section View Mode$$/\@section Viewモード/;'\
's/\@section Follow Mode$$/\@section Followモード/;'\
's/\@section Standard Faces$$/\@section 標準フェイス/;'\
's/\@section Text Scale$$/\@section テキストのスケール/;'\
's/\@section Font Lock mode$$/\@section Font Lockモード/;'\
's/\@section Displaying Boundaries$$/\@section バウンダリーの表示/;'\
's/\@section Useless Whitespace$$/\@section 不要なスペース/;'\
's/\@section Selective Display$$/\@section 選択的な表示/;'\
's/\@section Line Truncation$$/\@section 行の切り詰め/;'\
's/\@section Visual Line Mode$$/\@section Visual Lineモード/;' -i display-ja.texi ;; \
		"search-ja.texi" ) perl -pe \
's/\@section Incremental Search$$/\@section インクリメンタル検索/;'\
's/\@section Nonincremental Search$$/\@section 非インクリメンタル検索/;'\
's/\@section Word Search$$/\@section 単語検索/;'\
's/\@section Symbol Search$$/\@section シンボル検索/;'\
's/\@subsection Query Replace$$/\@subsection 問い合わせつき置換/;' -i search-ja.texi ;; \
		"fixit-ja.texi" ) perl -pe 's/\@section Undo$$/\@section Undo(取り消し)/' -i fixit-ja.texi ;; \
		"kmacro-ja.texi" ) perl -pe 's/\@chapter Keyboard Macros$$/\@chapter キーボードマクロ/' -i kmacro-ja.texi ;; \
		"files-ja.texi" ) perl -pe \
's/\@section File Names$$/\@section ファイルの名前/;'\
's/\@section Comparing Files$$/\@section ファイルの比較/;'\
's/\@section Diff Mode$$/\@section Diffモード/;'\
's/\@section File Archives$$/\@section ファイルアーカイブ/;'\
's/\@section Remote Files$$/\@section リモートファイル/;'\
's/\@section Quoted File Names$$/\@section ファイル名のクォート/;'\
's/\@section File Name Cache$$/\@section ファイル名キャッシュ/;'\
's/\@section Filesets$$/\@section ファイルセット/;' -i files-ja.texi ;; \
		"arevert-xtra-ja.texi" ) perl -pe 's/\@subsection Auto Reverting the Buffer Menu$$/\@subsection Buffer Menuの自動リバート/' -i arevert-xtra-ja.texi ;; \
		"buffers-ja.texi" ) perl -pe 's/\@section Indirect Buffers$$/\@section インダイレクトバッファー/' -i buffers-ja.texi ;; \
		"frames-ja.texi" ) perl -pe \
's/\@section Creating Frames$$/\@section フレームの作成/;'\
's/\@section Frame Commands$$/\@section フレームコマンド/;'\
's/\@section Fonts$$/\@section フォント/;'\
's/\@section Multiple Displays$$/\@section 複数ディスプレー/;'\
's/\@section Frame Parameters$$/\@section フレームパラメーター/;'\
's/\@section Scroll Bars$$/\@section スクロールバー/;'\
's/\@section Window Dividers$$/\@section Window Divider/;'\
's/\@section Drag and Drop$$/\@section ドラッグアンドドロップ/;'\
's/\@section Menu Bars$$/\@section メニューバー/;'\
's/\@section Tool Bars$$/\@section ツールバー/;'\
's/\@section Tooltips$$/\@section ツールチップ/;'\
's/\@section Mouse Avoidance$$/\@section マウスの回避/;'\
's/\@section Non-Window Terminals$$/\@section 非ウィンドウ端末/;' -i frames-ja.texi ;; \
		"mule-ja.texi" ) perl -pe \
's/\@section Language Environments$$/\@section 言語環境/;'\
's/\@section Input Methods$$/\@section インプットメソッド/;'\
's/\@section Coding Systems$$/\@section コーディングシステム/;'\
's/\@section Fontsets$$/\@section フォントセット/;'\
's/\@section Defining Fontsets$$/\@section フォントセットの定義/;'\
's/\@section Modifying Fontsets$$/\@section フォントセットの修正/;'\
's/\@section Undisplayable Characters$$/\@section 表示できない文字/;'\
's/\@section Charsets$$/\@section 文字セット/;'\
's/\@section Bidirectional Editing$$/\@section 双方向の編集/;' -i mule-ja.texi ;; \
		"modes-ja.texi" ) perl -pe \
's/\@section Major Modes$$/\@section メジャーモード/;'\
's/\@section Minor Modes$$/\@section マイナーモード/;' -i modes-ja.texi ;; \
		"indent-ja.texi" ) perl -pe \
's/\@chapter Indentation$$/\@chapter インデント/;'\
's/\@section Indentation Commands$$/\@section インデントコマンド/;'\
's/\@section Tab Stops$$/\@section タブストップ/;' -i indent-ja.texi ;; \
		"text-ja.texi" ) perl -pe \
's/\@section Words$$/\@section 単語/;'\
's/\@section Sentences$$/\@section センテンス/;'\
's/\@section Paragraphs$$/\@section パラグラフ/;'\
's/\@section Pages$$/\@section ページ/;'\
's/\@section Quotation Marks$$/\@section クォーテーションマーク/;'\
's/\@section Text Mode$$/\@section Textモード/;'\
's/\@section Outline Mode$$/\@section Outlineモード/;'\
's/\@section Org Mode$$/\@section Orgモード/;'\
's/\@section Nroff Mode$$/\@section Nroffモード/;'\
's/\@section Enriched Text$$/\@section Enrichedテキスト/;'\
's/\@subsection Enriched Mode$$/\@subsection Enrichedモード/;'\
's/\@subsection Hard and Soft Newlines$$/\@subsection ハード改行とソフト改行/;'\
's/\@subsection Table Recognition$$/\@subsection テーブルの認識/;'\
's/\@subsection Cell Justification$$/\@subsection セルの位置調整/;'\
's/\@subsection Table Rows and Columns$$/\@subsection テーブルの行と列/;' -i text-ja.texi ;; \
		"programs-ja.texi" ) perl -pe \
's/\@subsection Moving by Defuns$$/\@subsection defunの移動/;'\
's/\@subsection Imenu$$/\@subsection Imenuとは/;'\
's/\@subsection Comment Commands$$/\@subsection コメントコマンド/;'\
's/\@section MixedCase Words$$/\@section 大文字小文字の混ざった単語/;'\
's/\@section Semantic$$/\@section Semanticとは/;'\
's/\@section Asm Mode$$/\@section Asmモード/;' -i programs-ja.texi ;; \
		"fortran-xtra-ja.texi" ) perl -pe 's/\@subsection Fortran Comments$$/\@subsection Fortranのコメント/;' -i fortran-xtra-ja.texi ;; \
		"building-ja.texi" ) perl -pe \
's/\@section Compilation Mode$$/\@section Compilationモード/;'\
's/\@subsection Starting GUD$$/\@subsection GUDの開始/;'\
's/\@subsection Debugger Operation$$/\@subsection デバッガーの操作/;'\
's/\@subsection Commands of GUD$$/\@subsection GUDのコマンド/;'\
's/\@subsection GUD Customization$$/\@subsection GUDのカスタマイズ/;'\
's/\@subsection GDB Graphical Interface$$/\@subsection GDBのグラフィカルインターフェース/;'\
's/\@subsubsection GDB User Interface Layout$$/\@subsubsection GDBのユーザーインターフェースのレイアウト/;'\
's/\@subsubsection Source Buffers$$/\@subsubsection Sourceバッファー/;'\
's/\@subsubsection Breakpoints Buffer$$/\@subsubsection Breakpointsバッファー/;'\
's/\@subsubsection Threads Buffer$$/\@subsubsection Threadsバッファー/;'\
's/\@subsubsection Stack Buffer$$/\@subsubsection Stackバッファー/;'\
's/\@subsubsection Other GDB Buffers$$/\@subsubsection その他のGDBバッファー/;'\
's/\@subsubsection Watch Expressions$$/\@subsubsection ウォッチ式/;'\
's/\@subsubsection Multithreaded Debugging$$/\@subsubsection マルチスレッドのデバッグ/;' -i building-ja.texi ;; \
		"maintaining-ja.texi" ) perl -pe \
's/\@section Version Control$$/\@section バージョンコントロール/;'\
's/\@subsubsection Types of Log File$$/\@subsubsection ログファイルのタイプ/;'\
's/\@subsection VC Change Log$$/\@subsection VC Change Log/;'\
's/\@subsection VC Directory Mode$$/\@subsection VC Directoryモード/;'\
's/\@subsubsection VC Directory Commands$$/\@subsubsection VC Directoryコマンド/;'\
's/\@subsection Change Log Commands$$/\@subsection 変更ログコマンド/;'\
's/\@subsection Format of ChangeLog$$/\@subsection ChangeLogの書式/;'\
's/\@subsection Find Identifiers$$/\@subsection 識別子を探す/;'\
's/\@subsubsection Looking Up Identifiers$$/\@subsubsection 識別子のルックアップ/;'\
's/\@subsection Tags Tables$$/\@subsection タグテーブル/;'\
's/\@subsubsection Etags Regexps$$/\@subsubsection EtagsのRegexps/;'\
's/\@section Emacs Development Environment$$/\@section Emacs開発環境/;'  -i maintaining-ja.texi ;; \
		"vc1-xtra-ja.texi" ) perl -pe \
's/\@subsubsection Change Logs and VC$$/\@subsubsection 変更ログとVC/;'\
's/\@subsubsection Revision Tags$$/\@subsubsection リビジョンタグ/;'\
's/\@subsection Customizing VC$$/\@subsection VCのカスタマイズ/;' -i vc1-xtra-ja.texi ;; \
		"emerge-xtra-ja.texi" ) perl -pe \
's/\@subsection Overview of Emerge$$/\@subsection Emergeの概要/;'\
's/\@subsection Submodes of Emerge$$/\@subsection Emergeのサブモード/;'\
's/\@subsection Merge Commands$$/\@subsection マージコマンド/;'\
's/\@subsection Exiting Emerge$$/\@subsection Emergeの終了/;'\
's/\@subsection Fine Points of Emerge$$/\@subsection Emergeの細かい注意点/;' -i emerge-xtra-ja.texi ;; \
		"abbrevs-ja.texi" ) perl -pe \
's/\@chapter Abbrevs$$/\@chapter abbrev\(略語\)/;'\
's/\@section Abbrev Concepts$$/\@section abbrevの概念/;'\
's/\@section Defining Abbrevs$$/\@section abbrevの定義/;'\
's/\@section Saving Abbrevs$$/\@section abbrevの保存/;' -i abbrevs-ja.texi ;; \
		"dired-ja.texi" ) perl -pe \
's/\@section Operating on Files$$/\@section ファイルにたいする操作/;'\
's/\@section Shell Commands in Dired$$/\@section Diredでのシェルコマンド/;'\
's/\@section Subdirectories in Dired$$/\@section Diredでのサブディレクトリー/;'\
's/\@section Hiding Subdirectories$$/\@section サブディレクトリーを隠す/;' -i dired-ja.texi ;; \
		"calendar-ja.texi" ) perl -pe \
's/\@subsection Specified Dates$$/\@subsection 日付の指定/;'\
's/\@section Counting Days$$/\@section 日付のカウント/;'\
's/\@section Writing Calendar Files$$/\@section カレンダーファイルの記述/;'\
's/\@section Holidays$$/\@section 休日/;'\
's/\@subsection Displaying the Diary$$/\@subsection ダイアリーの表示/;'\
's/\@subsection Date Formats$$/\@subsection 日付のフォーマット/;'\
's/\@subsection Special Diary Entries$$/\@subsection 特別なダイアリーエントリー/;'\
's/\@section Appointments$$/\@section アポイントメント/;' -i calendar-ja.texi ;; \
		"cal-xtra-ja.texi" ) perl -pe \
's/\@subsection Date Display Format$$/\@subsection 日付の表示フォーマット/;'\
's/\@subsection Time Display Format$$/\@subsection 時刻の表示フォーマット/;'\
's/\@subsection Diary Display$$/\@subsection ダイアリーの表示/;'\
's/\@subsection Fancy Diary Display$$/\@subsection Fancy Diary表示/;' -i cal-xtra-ja.texi ;; \
		"sending-ja.texi" ) perl -pe \
's/\@chapter Sending Mail$$/\@chapter メールの送信/;'\
's/\@section Mail Aliases$$/\@section メールエイリアス/;'\
's/\@section Mail Commands$$/\@section メールコマンド/;'\
's/\@subsection Mail Sending$$/\@subsection メールの送信/;'\
's/\@subsection Citing Mail$$/\@subsection メールの引用/;'\
's/\@section Mail Signature$$/\@section メール署名/;'\
's/\@section Mail Amusements$$/\@section アミューズメント/;' -i sending-ja.texi ;; \
		"rmail-ja.texi" ) perl -pe \
's/\@section Rmail Attributes$$/\@section Rmailの属性/;'\
's/\@section \@code\{movemail\} program$$/\@section \@code\{movemail\}プログラム/;' -i rmail-ja.texi ;; \
		"misc-ja.texi" ) perl -pe \
's/\@subsection TCP Emacs server$$/\@subsection TCP Emacsサーバー/;'\
's/\@section Hyperlinking and Web Navigation Features$$/\@section ハイパーリンクとWebナビゲーション機能/;'\
's/\@subsection Embedded WebKit Widgets$$/\@subsection 埋め込みWebKitウィジェット/;'\
's/\@section Games and Other Amusements$$/\@section ゲーム、その他の娯楽/;'\
's/\@section Gnus$$/\@section Gnus/;'\
's/\@section Host Security$$/\@section ホストセキュリティー/;'\
's/\@section Network Security$$/\@section ネットワークセキュリティー/;'\
's/\@subsection DocView Navigation$$/\@subsection DocViewの操作/;'\
's/\@subsection DocView Searching$$/\@subsection DocViewの検索/;'\
's/\@subsection DocView Slicing$$/\@subsection DocViewのスライス/;'\
's/\@subsection DocView Conversion$$/\@subsection DocViewの変換/;'\
's/\@section Embedded WebKit Widgets$$/\@section 埋め込みWebKitウィジェット/;'\
's/\@subsection Shell Mode$$/\@subsection Shellモード/;'\
's/\@subsection Shell Prompts$$/\@subsection Shellプロンプト/;'\
's/\@subsubsection Shell History Copying$$/\@subsubsection Shellヒストリーのコピー/;'\
's/\@subsection Directory Tracking$$/\@subsection ディレクトリーの追跡/;'\
's/\@subsection Term Mode$$/\@subsection Termモード/;'\
's/\@subsection Serial Terminal$$/\@subsection シリアル端末/;'\
's/\@subsection Printing Package$$/\@subsection 印刷のためのパッケージ/;'\
's/\@section Editing Binary Files$$/\@section バイナリーファイルの編集/;'\
's/\@section Saving Emacs Sessions$$/\@section Emacsセッションの保存/;'\
's/\@section Emulation$$/\@section エミュレーション/;' -i misc-ja.texi ;; \
		"package-ja.texi" ) perl -pe 's/\@section Package Installation$$/\@section パッケージのインストール/' -i package-ja.texi ;; \
		"custom-ja.texi" ) perl -pe \
's/\@chapter Customization$$/\@chapter カスタマイズ/;'\
's/\@subsection Customization Groups$$/\@subsection カスタマイズグループ/;'\
's/\@subsection Changing a Variable$$/\@subsection 変数の変更/;'\
's/\@subsection Saving Customizations$$/\@subsection カスタマイズの保存/;'\
's/\@subsection Custom Themes$$/\@subsection カスタムテーマ/;'\
's/\@subsection Creating Custom Themes$$/\@subsection カスタムテーマの作成/;'\
's/\@section Variables$$/\@section 変数/;'\
's/\@subsection Hooks$$/\@subsection フック/;'\
's/\@subsubsection Specifying File Variables$$/\@subsubsection ファイル変数の指定/;'\
's/\@subsection Keymaps$$/\@subsection キーマップ/;'\
's/\@subsection Prefix Keymaps$$/\@subsection プレフィクスキーマップ/;'\
's/\@subsection Local Keymaps$$/\@subsection ローカルキーマップ/;'\
's/\@subsection Modifier Keys$$/\@subsection 修飾キー/;' -i custom-ja.texi ;; \
		"trouble-ja.texi" ) perl -pe \
's/\@subsection Emergency Escape$$/\@subsection 緊急エスケープ/;'\
's/\@subsection Understanding Bug Reporting$$/\@subsection バグレポートの理解/;'\
's/\@subsection Coding Standards$$/\@subsection コーディング規約/;'\
's/\@subsection Copyright Assignment$$/\@subsection 著作権の譲渡/;' -i trouble-ja.texi ;; \
		"cmdargs-ja.texi" ) perl -pe \
's/\@appendixsec Action Arguments$$/\@appendixsec 動作引数/;'\
's/\@appendixsec Initial Options$$/\@appendixsec 初期化オプション/;'\
's/\@appendixsubsec General Variables$$/\@appendixsubsec 一般的な変数/;' -i cmdargs-ja.texi ;; \
		"xresources-ja.texi" ) perl -pe \
's/\@appendixsec X Resources$$/\@appendixsec Xリソース/;'\
's/\@appendixsec GTK resources$$/\@appendixsec GTKリソース/;'\
's/\@appendixsubsec GTK\+ Resource Basics$$/\@appendixsubsec GTK\+リソースの基本/;'\
's/\@appendixsubsec GTK\+ widget names$$/\@appendixsubsec GTK\+ウィジェット名/;'\
's/\@appendixsubsec GTK styles$$/\@appendixsubsec GTKスタイル/;' -i xresources-ja.texi ;; \
		"macos-ja.texi" ) perl -pe \
's/\@section Mac \/ GNUstep Customization$$/\@section Mac \/ GNUstepでのカスタマイズ/;'\
's/\@section GNUstep Support$$/\@section GNUstepにたいするサポート/;' -i macos-ja.texi ;; \
		esac \
	else \
		cp -f original_texis/$@ $@; \
	fi; \

emacs-ja.html: $(TEXIS)
	texi2any --set-customization-variable TEXI2HTML=1 emacs-ja.texi

html/index.html: $(TEXIS)
	makeinfo -o html/ --html emacs-ja.texi

emacs-ja.info: $(TEXIS)
	makeinfo --no-split -o emacs-ja.info emacs-ja.texi

emacs-ja.pdf emacs-xtra-ja.pdf: $(TEXIS)
	TEX=ptex texi2dvi -c emacs-ja.texi
	dvipdfmx emacs-ja.dvi
	rm -f emacs-ja.dvi

	TEX=ptex texi2dvi -c emacs-xtra-ja.texi
	dvipdfmx emacs-xtra-ja.dvi
	rm emacs-xtra-ja.dvi

emacs-ja.txt: $(TEXI)
	texi2any --plaintext emacs-ja.texi > emacs-ja.txt

emacs-ja.texis.tar.gz: $(TEXIS)
	if [ ! -d emacs-ja.texis ]; \
	then \
		mkdir emacs-ja.texis/; \
	fi

	cp -f *.texi emacs-ja.texis
	tar cvfz ./emacs-ja.texis.tar.gz ./emacs-ja.texis
