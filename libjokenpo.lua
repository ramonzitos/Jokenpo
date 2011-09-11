-- libjokenpo.lua
-- Funcoes para pegar dados
function raw_input (str)
  if not str then str = "" end
  io.write(str)
  io.flush()
  return io.stdin:read()
end
function index (arr, elm)
  for i=1, #arr do
    if arr[i] == elm then return i end
  end
  return nil
end
function get_at(arr, num)
  local n = 0
  if num <= 0 then
    n = #arr + num
  else
    n = num
  end
  return arr[n]
end
function input (str)
  if not str then str = "" end
  io.write(str)
  io.flush()
  num = tonumber(io.stdin:read())
  if type(num) ~= "number" then error("Não é numero") end
  return num
end
-- Definindo variaveis, a classe, outras funcoes
Jogo = {}
Jogo.__index = Jogo
function Jogo:novo(num)
  self.choices = {"Pedra", "Papel", "Tesoura"}
  self.choice = self.choices[num]
  return self
end
function Jogo:jogar()
  -- Iniciando o gerador
  math.randomseed( os.time() )
  math.random(); math.random(); math.random()
  -- OK. :-D
  math.random(#self.choices)
  self.cpuchoice = self.choices[math.random(#self.choices)]
  return self.cpuchoice
end
function Jogo:ganhei()
  if get_at(self.choices, (index(self.choices, self.choice) - 1)) == self.cpuchoice then
    return true
  elseif self.choice == self.cpuchoice then
    return nil
  else
    return false
  end
end
