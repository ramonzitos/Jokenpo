require "lang"
require "libjokenpo"
require "iuplua"
langs = {}
nlangs = {}
for k,v in pairs(trans) do table.insert(langs, tostring(k)); table.insert(nlangs, trans[tostring(k)].desc) end
function main()
  res, cho = iup.GetParam(trans[clang].escolha_jogada, nil, trans[clang].esc_sorte.." %l|"..table.concat(choi, "|").."|\n", 0)
  if res then
    label = iup.label{ title = trans[clang].cpu_escolhendo }
    dlg = iup.dialog{ label; title = "Jokenpo" }
    dlg:show()
    timer = iup.timer{time=2000}
    function timer:action_cb()
      jogo = Jogo:novo(cho+1)
      jogo:jogar()
      dlg:destroy()
      label = nil
      if jogo:ganhei() then
	iup.Message("Jokenpo", trans[clang].ganhou)
      elseif jogo:ganhei() == nil then
	iup.Message("Jokenpo", trans[clang].empate)
      else
	iup.Message("Jokenpo", trans[clang].perdeu)
      end
      self.run = "NO"
      r = iup.Alarm("Jokenpo", trans[clang].jogar_novo, trans[clang].sim, trans[clang].nao)
      if r == 1 then main() end
    end
    timer.run = "YES"
    iup.MainLoop()
  end
end
res, idlang = iup.GetParam("Language", nil, "Choose your language: %l|"..table.concat(nlangs, "|").."|\n", 0)
if res then
  clang = langs[idlang+1]
  choi = {trans[clang].pedra, trans[clang].papel, trans[clang].tesoura}
  main()
end
