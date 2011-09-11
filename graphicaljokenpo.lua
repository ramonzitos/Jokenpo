require "libjokenpo"
require "iuplua"
choi = {"Pedra", "Papel", "Tesoura"}
function main()
  res, cho = iup.GetParam("Escolha sua jogada", nil, "Escolha e tente a sorte: %l|"..table.concat(choi, "|").."|\n", 0)
  print(res)
  if res then
    print(0)
    label = iup.label{ title = " A CPU esta escolhendo sua jogada... " }
    dlg = iup.dialog{ label; title = "Jokenpo" }
    dlg:show()
    timer = iup.timer{time=2000}
    function timer:action_cb()
      jogo = Jogo:novo(cho+1)
      jogo:jogar()
      dlg:destroy()
      label = nil
      if jogo:ganhei() then
	iup.Message("Jokenpo", "Você ganhou!")
      elseif jogo:ganhei() == nil then
	iup.Message("Jokenpo", "Empate")
      else
	iup.Message("Jokenpo", "Você perdeu")
      end
      self.run = "NO"
      r = iup.Alarm("Jokenpo", "Você quer jogar de novo?", "Sim", "Não")
      if r == 1 then main() end
    end
    timer.run = "YES"
    iup.MainLoop()
  end
end
main()
