_: {
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig.settings = {
      all_compile = false; # 強制コンパイルをオフ
      experimental = true; # もし新しい機能を使うなら
    };
  };
}
