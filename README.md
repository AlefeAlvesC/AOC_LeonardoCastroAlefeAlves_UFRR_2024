# AOC_LeonardoCastroAlefeAlves_UFRR_2024

## Projeto Final AOC

---

**Integrantes:** [Leonardo Castro](https://github.com/thetwelvedev) e [Álefe Alves](https://github.com/AlefeAlvesC).

**Descrição:** Essa atividade tem como finalidade projetar e implementar um processador RISC de 8 bits, semelhante ao MIPS, utilizando VHDL. O projeto inclui a especificação das instruções, datapath, criação do processador e simulações. As instruções obrigatórias incluem load, store, soma, subtração, beq e salto incondicional.

---

## Índice
- [AOC\_LeonardoCastroAlefeAlves\_UFRR\_2024](#aoc_leonardocastroalefealves_ufrr_2024)
  - [Projeto Final AOC](#projeto-final-aoc)
  - [Índice](#índice)
  - [Datapath](#datapath)
  - [Instruções](#instruções)
      - [Tipo R](#tipo-r)
      - [Tipo I](#tipo-i)
      - [Tipo J](#tipo-j)
  - [Processador](#processador)
  - [Simulações](#simulações)
  - [Relatório](#relatório)
  - [Referências](#referências)

---

## Datapath
<div style="font-size: 20px; font-weight: bold; color: black;">Descrição:</div>

![Imagem do Datapath](/datapath/datapath-view.png)

---

## Instruções
<div style="font-size: 20px; font-weight: bold; color: black;">As instruções estão organizadas em diferentes formatos com base no opcode:</div>

#### Tipo R

> Instruções que operam com registradores, onde rs e rt são os registradores de origem e destino, respectivamente.

| Opcode | rs| rt |
|--------|------|--------|
| 7 - 5  | 4 - 3 | 2 - 1 |
|3 bits |2 bits | 2 bits |

#### Tipo I

**Load**: Instruções que carregam dados da memória para um registrador, usando um valor imediato (Immediate) como offset.

| Opcode | rs| Immediate |
|--------|------|--------|
| 7 - 5  | 4 - 3 | 2 - 0 |
|3 bits |2 bits | 3 bits |

**Store**: Instruções que armazenam dados de um registrador na memória.

| Opcode | rs| Immediate |
|--------|------|--------|
| 7 - 5  | 4 - 3 | 2 - 0 |
|3 bits |2 bits | 3 bits |

**Beq**: Instruções de desvio condicional que comparam dois registradores (rs e rt) e pulam para um endereço se forem iguais.

**1° Instrução**
| Opcode | rs| rt |
|--------|------|--------|
| 7 - 5  | 4 - 3 | 2 - 1 |
|3 bits |2 bits | 2 bits |

**2° Instrução**
| Opcode | rs| Adress |
|--------|------|--------|
| 7 - 5  | 4 - 3 | 2 - 0 |
|3 bits |2 bits | 3 bits |

#### Tipo J

**Jump**: Instruções que alteram o fluxo de execução para um endereço específico.

| Opcode | Adress |
|--------|------|
| 7 - 5  | 4 - 0 |
|3 bits | 5 bits |

<div style="font-size: 20px; font-weight: bold; color: black;">Para uma vizualização mais detalhada do relatório:</div

* [Acesse as instruções](/instrucoes/instruções.pdf)

---

## Processador

---

## Simulações

---

## Relatório

<div style="font-size: 20px; font-weight: bold; color: black;">Para uma vizualização mais detalhada do relatório:</div> 

* [Acesse o relatório](/relatorio/relatório-trabalho-final-aoc.docx)

---

## Referências

STALLINGS, William; BOSNIC, Ivan; VIEIRA, Daniel. **Arquitetura e organização de computadores**. 8. ed. São Paulo: Prentice Hall, 2006.
PATTERSON, David A. **Organização e projeto de computadores**. 3. ed. Rio de Janeiro: Elsevier, 2005.
