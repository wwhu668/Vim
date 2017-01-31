nmap <BS> gci 
"set imactivatekey=C-space  
"inoremap <ESC> <ESC>:set iminsert=2<CR> 

" =============================================================================
"        << �жϲ���ϵͳ�� Windows ���� Linux ���ж����ն˻��� Gvim >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < �жϲ���ϵͳ�Ƿ��� Windows ���� Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif
 
" -----------------------------------------------------------------------------
"  < �ж����ն˻��� Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
 
 
" =============================================================================
"                          << ����Ϊ���Ĭ������ >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < Windows Gvim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()
 
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif
 
" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch        "��������
    set incsearch       "������Ҫ����������ʱ��ʵʱƥ��
 
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
 
    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim
 
        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif
 
        set mouse=a                    " ���κ�ģʽ���������
        set t_Co=256                   " ���ն�����256ɫ
        set backspace=2                " �����˸������
 
        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif
 
 
" =============================================================================
"                          << ����Ϊ�û��Զ������� >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < Vundle ������������� >
" -----------------------------------------------------------------------------
" ���ڸ�����Ĺ���vim����������÷��ο� :h vundle ����
" Vundle���߰�װ����Ϊ���ն�������������
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" ������� windows ��װ�ͱ����Ȱ�װ "git for window"���ɲ�����������
 
set nocompatible                                      "���� Vi ����ģʽ
filetype off                                          "�����ļ��������
 
if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" ʹ��Vundle�����������������Ҫ�С�
Bundle 'gmarik/vundle'
" 
"" ����ΪҪ��װ����µĲ������ͬ�ֿⶼ�У�������д�淶��ο�������
Bundle 'jiangmiao/auto-pairs'
Bundle 'javascript.vim'
Bundle 'mattn/emmet-vim'
"Bundle 'bufexplorer.zip'
""Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'Yggdroot/indentLine'
"Bundle 'Shougo/neocomplcache.vim'
Bundle 'Shougo/neocomplete.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'repeat.vim'
"Bundle 'wesleyche/SrcExpl'
"Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'taglist.vim'
Bundle 'ZoomWin'
Bundle 'vim-multiple-cursors'
Bundle 'php.vim'
Bundle 'scrooloose/syntastic'
Bundle 'suan/vim-instant-markdown'
Bundle 'spf13/PIV'
Bundle 'arnaud-lb/vim-php-namespace'


" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
" ע��ʹ��utf-8��ʽ����������Դ�롢�ļ�·�����������ģ����򱨴�
set encoding=utf-8                                    "����gvim�ڲ����룬Ĭ�ϲ�����
set fileencoding=utf-8                                "���õ�ǰ�ļ����룬���Ը��ģ��磺gbk��ͬcp936��
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "����֧�ִ򿪵��ļ��ı���
 
" �ļ���ʽ��Ĭ�� ffs=dos,unix
set fileformat=unix                                   "�����£���ǰ���ļ���<EOL>��ʽ�����Ը��ģ��磺dos��windowsϵͳ���ã�
set fileformats=unix,dos,mac                          "�����ļ���<EOL>��ʽ����
 
if (g:iswindows && g:isGUI)
    "����˵�����
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
 
    "���consle�������
    language messages zh_CN.utf-8
endif
"��������
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set helplang=cn
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" -----------------------------------------------------------------------------
"  < ��д�ļ�ʱ������ >
" -----------------------------------------------------------------------------
filetype on                                           "�����ļ��������
filetype plugin on                                    "��Բ�ͬ���ļ����ͼ��ض�Ӧ�Ĳ��
filetype plugin indent on                             "��������
set smartindent                                       "�������ܶ��뷽ʽ
set expandtab                                         "��Tab��ת��Ϊ�ո�
set tabstop=4                                         "����Tab���Ŀ�ȣ����Ը��ģ��磺���Ϊ2
set shiftwidth=4                                      "����ʱ�Զ�������ȣ��ɸ��ģ����ͬtabstop��
set smarttab                                          "ָ����һ��backspace��ɾ��shiftwidth���
set foldenable                                        "�����۵�
"set foldmethod=indent                                 "indent �۵���ʽ
" set foldmethod=marker                                "marker �۵���ʽ
 
" ����ģʽ���ÿո�������ع���������۵���ע��zR չ�������۵���zM �ر������۵���
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
 
" ���ļ����ⲿ���޸ģ��Զ����¸��ļ�
set autoread
 
" ����ģʽ������ cS �����β�ո�
nmap cS :%s/\s\+$//g<CR>:noh<CR>
 
" ����ģʽ������ cM �����β ^M ����
nmap cM :%s/\r$//g<CR>:noh<CR>
 
set ignorecase                                        "����ģʽ����Դ�Сд
set smartcase                                         "�������ģʽ������д�ַ�����ʹ�� 'ignorecase' ѡ�ֻ������������ģʽ���Ҵ� 'ignorecase' ѡ��ʱ�Ż�ʹ��
"set noincsearch                                       "������Ҫ����������ʱ��ȡ��ʵʱƥ��
 
" ����ģʽ�� �ƶ�
imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>

" �ڲ�ͬ�Ĵ����ƶ�
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
" Visual shifting (does not exit Visual mode) ����ѡ��״̬
vnoremap < <gv
vnoremap > >gv
" For when you forget to sudo.. Really Write the file. ʹ�� sudo �����ļ�
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%




 
" ����ÿ�г���80�е��ַ���ʾ��������������»��ߣ��������þ�ע�͵�
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
 
" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set number                                            "��ʾ�к�
set laststatus=2                                      "����״̬����Ϣ
set cmdheight=1                                       "���������еĸ߶�Ϊ2��Ĭ��Ϊ1
set cursorline                                        "ͻ����ʾ��ǰ��
 set guifont=YaHei_Consolas_Hybrid:h10                 "��������:�ֺţ��������ƿո����»��ߴ��棩
"set nowrap                                            "���ò��Զ�����
set shortmess=atI                                     "ȥ����ӭ����
 
" ���� gVim ���ڳ�ʼλ�ü���С
if g:isGUI
    " au GUIEnter * simalt ~x                           "��������ʱ�Զ����
    winpos 100 10                                     "ָ�����ڳ��ֵ�λ�ã�����ԭ������Ļ���Ͻ�
    set lines=38 columns=120                          "ָ�����ڴ�С��linesΪ�߶ȣ�columnsΪ���
endif
 
" ���ô�����ɫ����
if g:isGUI
"    colorscheme Tomorrow-Night-Eighties               "Gvim��ɫ����
    colorscheme solarized
    let g:solarized_italic=0
"    set background=dark
else
    colorscheme Tomorrow-Night-Eighties               "�ն���ɫ����
endif
 
" ��ʾ/���ز˵������������������������� Ctrl + F11 �л�
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif
 
 
" -----------------------------------------------------------------------------
"  < ���������Ԥ�� Html �� PHP �ļ� >
" -----------------------------------------------------------------------------
" �޸�ǰ����ͨ����ģ�飬�������ٸ��Ա������
 
" F5 �������������д���������Ԥ��������ǰ��ȷ���а�װ��Ӧ�������������������ú��䰲װĿ¼
if g:iswindows
    "����Ϊֻ֧��Windowsϵͳ�������
 
    " ����ϵͳIE�����Ԥ���������ж�ؿɽ���ע��
    "nmap <F5>ie :call ViewInBrowser("ie")<cr>
    "imap <F5>ie <ESC>:call ViewInBrowser("ie")<cr>
 
    " ����IETester(IE���Թ���)Ԥ��������а�װ��ȡ��ע��
    " nmap <F5>ie6 :call ViewInBrowser("ie6")<cr>
    " imap <F5>ie6 <ESC>:call ViewInBrowser("ie6")<cr>
    " nmap <F5>ie7 :call ViewInBrowser("ie7")<cr>
    " imap <F5>ie7 <ESC>:call ViewInBrowser("ie7")<cr>
    " nmap <F5>ie8 :call ViewInBrowser("ie8")<cr>
    " imap <F5>ie8 <ESC>:call ViewInBrowser("ie8")<cr>
    " nmap <F5>ie9 :call ViewInBrowser("ie9")<cr>
    " imap <F5>ie9 <ESC>:call ViewInBrowser("ie9")<cr>
    " nmap <F5>ie10 :call ViewInBrowser("ie10")<cr>
    " imap <F5>ie10 <ESC>:call ViewInBrowser("ie10")<cr>
    " nmap <F5>iea :call ViewInBrowser("iea")<cr>
    " imap <F5>iea <ESC>:call ViewInBrowser("iea")<cr>
elseif g:islinux
    "����Ϊֻ֧��Linuxϵͳ�������
    "��δ���ã�����ʱ����Ū��
endif
 
"����Ϊ֧��Windows��Linuxϵͳ�������
 
" ����Firefox�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>ff :call ViewInBrowser("ff")<cr>
" imap <F5>ff <ESC>:call ViewInBrowser("ff")<cr>
 
" ����Maxthon(����)�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>ay :call ViewInBrowser("ay")<cr>
" imap <F5>ay <ESC>:call ViewInBrowser("ay")<cr>
 
" ����Opera�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>op :call ViewInBrowser("op")<cr>
" imap <F5>op <ESC>:call ViewInBrowser("op")<cr>
 
" ����Chrome�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>cr :call ViewInBrowser("cr")<cr>
" imap <F5>cr <ESC>:call ViewInBrowser("cr")<cr>
 
" ��������ú���
function! ViewInBrowser(name)
    if expand("%:e") == "php" || expand("%:e") == "html"
        exe ":update"
        if g:iswindows
            "��ȡҪԤ�����ļ�·��������·���е�'\'�滻Ϊ'/'��ͬʱ��·�����ֵı���ת��Ϊgbk��ͬcp936��
            let file = iconv(substitute(expand("%:p"), '\', '/', "g"), "utf-8", "gbk")
 
            "�����·�����ã�·����ʹ��'/'б�ܣ�����·�������˫�����������
            "����ֻ������ϵͳIE��������������������Ŀɽ���ȡ��ע�ͣ����Ȱ�װ�������úð�װ·������Ҳ�ɰ�������
            let SystemIE = "C:/progra~1/intern~1/iexplore.exe"  "ϵͳ�Դ�IEĿ¼
            " let IETester = "F:/IETester/IETester.exe"           "IETester����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Chrome = "F:/Chrome/Chrome.exe"                 "Chrome����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Firefox = "F:/Firefox/Firefox.exe"              "Firefox����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Opera = "F:/Opera/opera.exe"                    "Opera����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Maxthon = "C:/Progra~2/Maxthon/Bin/Maxthon.exe" "Maxthon����Ŀ¼���ɰ�ʵ�ʸ��ģ�
 
            "����������������ã��Ҳ��Ե���phpStudy2014���ɸ����Լ����޸ģ�����·�������˫�����������
            let htdocs ="F:/phpStudy2014/WWW/"                  "�����������ַ��Ŀ¼���ɰ�ʵ�ʸ��ģ�
            let url = "localhost"                               "�����������ַ���ɰ�ʵ�ʸ��ģ�
        elseif g:islinux
            "��ʱ��û�����ã���ʱ����Ū�ˡ�
        endif
 
        "�����������д���ɸ���ʵ��������ע�⣬���������·����û�ж�����ı������Ⱥ��ұ�Ϊ���������ܳ���������Ӵ���ɽ���ע�ͻ�ɾ����
        let l:browsers = {}                             "������д�ֵ���������в���ɾ����ע��
        " let l:browsers["cr"] = Chrome                   "Chrome�������д
        " let l:browsers["ff"] = Firefox                  "Firefox�������д
        " let l:browsers["op"] = Opera                    "Opera�������д
        " let l:browsers["ay"] = Maxthon                  "�����������д
        let l:browsers["ie"] = SystemIE                 "ϵͳIE�������д
        " let l:browsers["ie6"] = IETester."-ie6"         "����IETESTER������IE6Ԥ����д�������Ӳ�����
        " let l:browsers["ie7"] = IETester."-ie7"         "����IETESTER������IE7Ԥ����д�������Ӳ�����
        " let l:browsers["ie8"] = IETester."-ie8"         "����IETESTER������IE8Ԥ����д�������Ӳ�����
        " let l:browsers["ie9"] = IETester."-ie9"         "����IETESTER������IE9Ԥ����д�������Ӳ�����
        " let l:browsers["ie10"] = IETester."-ie10"       "����IETESTER������IE10Ԥ����д�������Ӳ�����
        " let l:browsers["iea"] = IETester."-al"          "����IETESTER������֧�ֵ�����IE�汾Ԥ����д�������Ӳ�����
 
        if stridx(file, htdocs) == -1   "�ļ����ڱ������������Ŀ¼����ֱ��Ԥ���������ܽ���PHP�ļ���
           exec ":silent !start ". l:browsers[a:name] ." file://" . file
        else    "�ļ��ڱ������������Ŀ¼������ñ����������������Ԥ�������������������������
            let file = substitute(file, htdocs, "http://".url."/", "g")    "ת���ļ�·��Ϊ�����������ַ·��
            exec ":silent !start ". l:browsers[a:name] file
        endif
    else
        echohl WarningMsg | echo " please choose the correct source file"
    endif
endfunction
 
" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set writebackup                             "�����ļ�ǰ�������ݣ�����ɹ���ɾ���ñ���
set nobackup                                "�����ޱ����ļ�
" set noswapfile                              "��������ʱ�ļ�
 set vb t_vb=                                "�ر���ʾ��
au GuiEnter * set t_vb=                     "�ر�������ʾ
 
 
" =============================================================================
"                          << ����Ϊ���ò������ >>
" =============================================================================
"

" -----------------------------------------------------------------------------
"  < ctrlp.vim ������� >
" -----------------------------------------------------------------------------
" һ��ȫ·��ģ���ļ�����������������ʹ�ã�... �����������ϸ������ :h ctrlp
" ����ģʽ�����룺Ctrl + p ���ò��
" CtrlP ����
let g:ctrlp_open_multiple_files = 'v'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(log|jpg|png|jpeg)$',
  \ }

" -----------------------------------------------------------------------------
"  < indentLine ������� >
" -----------------------------------------------------------------------------
" ������ʾ�����ߣ��� indent_guides ����ʾ��ʽ�ϲ�ͬ�������Լ�ϲ��ѡ����
" ����/�رն�����
nmap <leader>il :IndentLinesToggle<CR>
" ����Gvim�Ķ�������ʽ
if g:isGUI
    "let g:indentLine_char = "��"
    let g:indentLine_first_char = "��"
endif
 
" -----------------------------------------------------------------------------
"  < auto-pairs ������� >
" -----------------------------------------------------------------------------
" ���������������Զ���ȫ���������뺯��ԭ����ʾ���echofunc��ͻ
" �����Ҿ�û�м���echofunc���
 
" -----------------------------------------------------------------------------
"  < BufExplorer ������� >
" -----------------------------------------------------------------------------
" �������ɵ��ڻ������л����൱����һ�ֶ���ļ�����л���ʽ��
" <Leader>be �ڵ�ǰ������ʾ�����б���ѡ���ļ�
" <Leader>bs ˮƽ�ָ����ʾ�����б����ڻ����б����д�ѡ���ļ�
" <Leader>bv ��ֱ�ָ����ʾ�����б����ڻ����б����д�ѡ���ļ�
 
 
" -----------------------------------------------------------------------------
"  < emmet-vim��ǰ��ΪZen coding�� ������� >
" -----------------------------------------------------------------------------
" HTML/CSS������ٱ�д��������ϸ������ :h emmet.txt
 
 
" " -----------------------------------------------------------------------------
" "  < MiniBufExplorer ������� >
" " -----------------------------------------------------------------------------
" " ��������Ͳ���Buffer
" " ��Ҫ����ͬʱ�򿪶���ļ��������л�
 
" " let g:miniBufExplMapWindowNavArrows = 1     "��Ctrl�ӷ�����л����������ҵĴ�����ȥ
" let g:miniBufExplMapWindowNavVim = 1        "��<C-k,j,h,l>�л����������ҵĴ�����ȥ
" let g:miniBufExplMapCTabSwitchBufs = 1      "������ǿ����������ֻ����Windows�в����ã�
" "                                            <C-Tab> ��ǰѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�
" "                                            <C-S-Tab> ���ѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�
 
 
" -----------------------------------------------------------------------------
"  < neocomplcache ������� >
" -----------------------------------------------------------------------------
" �ؼ��ֲ�ȫ���ļ�·����ȫ��tag��ȫ�ȵȣ����֣��ǳ����ã��ٶȳ��졣
let g:neocomplcache_enable_at_startup = 1     "vim ����ʱ���ò��
" let g:neocomplcache_disable_auto_complete = 1 "���Զ�������ȫ�б�
" �ڵ�����ȫ�б���� <c-p> �� <c-n> ��������ѡ��Ч���ȽϺ�
 
" -----------------------------------------------------------------------------
"  < nerdcommenter ������� >
" -----------------------------------------------------------------------------
" ����Ҫ����C/C++����ע��(������Ҳ��)
" ����Ϊ���Ĭ�Ͽ�ݼ������е�˵������C/C++Ϊ���ģ�������������
" <Leader>ci ��ÿ��һ�� /* */ ע��ѡ����(ѡ������������)����������ȡ��ע��
" <Leader>cm ��һ�� /* */ ע��ѡ����(ѡ������������)������������ظ�ע��
" <Leader>cc ��ÿ��һ�� /* */ ע��ѡ���л���������������ظ�ע��
" <Leader>cu ȡ��ѡ������(��)��ע�ͣ�ѡ������(��)��������һ�� /* */
" <Leader>ca ��/*...*/��//������ע�ͷ�ʽ���л����������Կ��ܲ�һ���ˣ�
" <Leader>cA ��βע��
let NERDSpaceDelims = 1                     "����ע�ͷ�֮����ע�ͷ�֮ǰ���пո�
let NERDShutUp=1 
"map <C-h> ,ci
 
" -----------------------------------------------------------------------------
"  < nerdtree ������� >
" -----------------------------------------------------------------------------
" ��Ŀ¼��ṹ���ļ�������
 
" ����ģʽ������ F2 ���ò��
nmap <F2> :NERDTreeToggle<CR>
 
" -----------------------------------------------------------------------------
"  < powerline ������� >
" -----------------------------------------------------------------------------
" ״̬����������õ�״̬��Ч��
 
" -----------------------------------------------------------------------------
"  < repeat ������� >
" -----------------------------------------------------------------------------
" ��Ҫ��"."�������ظ��ϴβ��ʹ�õ�����
 
" -----------------------------------------------------------------------------
"  < SrcExpl ������� >
" -----------------------------------------------------------------------------
" ��ǿԴ����������书�ܾ���Windows�е�"Source Insight"
nmap <F3> :SrcExplToggle<CR>                "��/���������
 
" ���� // ע�ӷ��
let c_cpp_comments = 0
 
" -----------------------------------------------------------------------------
"  < surround ������� >
" -----------------------------------------------------------------------------
" ���ٸ�����/�����������ӷ��ţ�����html��ǩ����ȱ���ǲ�����"."���ظ�����
" ���� repeat ������Խ��������⣬��ϸ������ :h surround.txt
 
" -----------------------------------------------------------------------------
"  < Tagbar ������� >
" -----------------------------------------------------------------------------
" ��� TagList �ܸ��õ�֧���������
 
" ����ģʽ������ tb ���ò��������д� TagList �������Ƚ���ر�
nmap tb :TlistClose<CR>:TagbarToggle<CR>
 
let g:tagbar_width=30                       "���ô��ڿ��
" let g:tagbar_left=1                         "����ര������ʾ
 
" -----------------------------------------------------------------------------
"  < TagList ������� >
" -----------------------------------------------------------------------------
" ��Ч�����Դ��, �书�ܾ���vc�е�workpace
" �������г��˵�ǰ�ļ��е����к�,ȫ�ֱ���, ��������
 
" ����ģʽ������ tl ���ò��������д� Tagbar �������Ƚ���ر�
nmap tl :TagbarClose<CR>:Tlist<CR>
 
let Tlist_Show_One_File=1                   "ֻ��ʾ��ǰ�ļ���tags
" let Tlist_Enable_Fold_Column=0              "ʹtaglist�������ʾ��ߵ��۵���
let Tlist_Exit_OnlyWindow=1                 "���Taglist���������һ���������˳�Vim
let Tlist_File_Fold_Auto_Close=1            "�Զ��۵�
let Tlist_WinWidth=30                       "���ô��ڿ��
let Tlist_Use_Right_Window=1                "���Ҳര������ʾ

" -----------------------------------------------------------------------------
"  < vim-multiple-cursors ������� >
" -----------------------------------------------------------------------------
" ���ڶ���༭����
" Default mapping
let g:multi_cursor_next_key='<C-n>'         "��ʼ�������ģʽ��ѡ�й���µĵ��ʣ������� Ctrl-n ѡ����һ����ͬ�ĵ���
let g:multi_cursor_prev_key='<C-p>'         "����ѡһ��
let g:multi_cursor_skip_key='<C-x>'         "��������һ����ͬ����
let g:multi_cursor_quit_key='<Esc>'         "�˳�

" -----------------------------------------------------------------------------
"  < syntastic �﷨��� >
" -----------------------------------------------------------------------------
" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
 
" -----------------------------------------------------------------------------
"  < ZoomWin ������� >
" -----------------------------------------------------------------------------
" ���ڷָ�ڵ�����뻹ԭ
" ����ģʽ�°���ݼ� <c-w>o ������뻹ԭ���л�
 
" =============================================================================
"                          << ����Ϊ���ù������� >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < ctags �������� >
" -----------------------------------------------------------------------------
" ���������ǳ��ķ���,�����ں���,����֮����ת��
set tags=./tags;                            "���ϼ�Ŀ¼�ݹ����tags�ļ�������ֻ����Windows�²����ã�
 
 
" =============================================================================
"                          << ����Ϊ�����Զ��������� >>
" =============================================================================
 
" �Զ��л�Ŀ¼Ϊ��ǰ�༭�ļ�����Ŀ¼
au BufRead,BufNewFile,BufEnter * cd %:p:h
 
" =============================================================================
"                     << windows �½�� Quickfix �������� >>
" =============================================================================
" windows Ĭ�ϱ���Ϊ cp936���� Gvim(Vim) �ڲ�����Ϊ utf-8�����Գ������Ϊ����
" ���´�����Խ�����Ϊ cp936 �������Ϣת��Ϊ utf-8 ���룬�Խ�������������
" ������ֻ�������Ϣȫ��Ϊ���Ĳ��������Ч������������Ϣ����Ӣ��ϵģ��ǿ���
" ���ɹ������������һ���������룬�����Ϣȫ��ΪӢ�ĵĺ��񲻻�����
" ��������ϢΪ����Ŀ�����һ������Ĵ��룬������оͻ��Ǹ���ע�͵�
 
" if g:iswindows
"     function QfMakeConv()
"         let qflist = getqflist()
"         for i in qflist
"            let i.text = iconv(i.text, "cp936", "utf-8")
"         endfor
"         call setqflist(qflist)
"      endfunction
"      au QuickfixCmdPost make call QfMakeConv()
" endif
 
" =============================================================================
"                          << ���� >>
" =============================================================================
" ע�����������е�"<Leader>"�ڱ����������Ϊ"\"����������ķ�б�ܣ�����<Leader>t
" ָ�ڳ���ģʽ�°�"\"����"t"�������ﲻ��ͬʱ���������Ȱ�"\"����"t"���������һ
" ���ڣ���<Leader>cs���Ȱ�"\"���ٰ�"c"���ٰ�"s"������Ҫ�޸�"<leader>"�������԰�
" ���������ȡ��ע�ͣ����޸�˫�����еļ�Ϊ����Ҫ�ģ����޸�Ϊ���ż���
 
let mapleader = ";"
vmap <BS> gci

" php ����ע��  php-doc.vim
source   $VIM/vimfiles/php-doc.vim 
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags 
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

"let g:user_emmet_expandabbr_key = '<Tab>'

