# Desenvolvimento distribuído e onde aplicá-lo

Você já ouviu falar sobre desenvolvimento distribuído?

Bem, poucos desenvolvedores conhecem essa estratégia, outros já utilizam mas não tem ideia do fluxo no qual estão inseridos...

Vamos conhecê-las?

### Fluxo de trabalho centralizado

Este fluxo promove a colaboração de todo o time de desenvolvimento de uma determinada linguagem em um único repositório centralizado.

---

<p align="center">
<img src="18333fig0501-tn.png">
</p>

### Onde aplicá-lo? :hammer:

Em times pequenos, combinado há um fluxo de organização orientado a funcionalidades, permite uma rápida integração de código.<br>

> Gitflow

<p align="center">
<img src="git-model@2x.png">
</p>

---

### Fluxo de Trabalho do Gerente de Integração

Neste caso, cada desenvolvedor realiza um fork do projeto à ser contribuído, evoluí o código nessa cópia e abre um Pull Request para o mantenedor do repositório oficial.<br>
Para a posterior integração dessas alterações, o mantenedor adiciona essa cópia como um novo repositório remoto, fazendo o merge das alterações localmente.<br> Feito isso, o mantenedor da push das alterações para o repositório oficial.

---

<p align="center">
<img src="18333fig0502-tn.png">
</p>

### Onde aplicá-lo? :hammer:



---

### Fluxo de Trabalho de Ditador e Tenentes

Neste fluxo, temos 3 papéis fundamentais: Os desenvolvedores, os tenentes e os ditadores.<br>
Os desenvolvedores trabalham a partir de um fork do repositório oficial que está sob o dominio do ditador, a partir da branch master.<br>
Os tenentes realizam o merge dos códigos dos desenvolvedores em uma branch de integração, onde posteriormente, o ditador fará o merge dessa branch na sua branch master.<br>
Feito isso, o ditador da push das suas alterações para o repositório oficial, onde os desenvolvedores farão o rebase com as novas alterações.

---

<p align="center">
<img src="18333fig0503-tn.png">
</p>

---
