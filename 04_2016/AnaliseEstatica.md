# Implementando a Análise Estática na Integração Contínua

Durante o desenvolvimento de um software, é comum encontrarmos bugs, más-práticas, além de problemas relacionados a estilo.<br />
A análise estática visa evidenciar esses problemas, sendo parte fundamental no processo de melhoria da qualidade do código-fonte.<br />
Com essa prática adotada em tempo de desenvolvimento, será muito menos doloroso a entrega em produção, podendo diminuir drasticamente os possíveis prejuizos gerados por esses problemas.<br />
Da mesma forma, o uso de boas práticas de orientação a objetos permite que o código seja flexível e suporte mudanças de forma mais tranquila, segura e natural.<br />
Partindo desse contexto, a etapa da qualidade se torna extremamente relevante no processo de Integração Contínua, pois é através desta que poderemos entregar um software íntegro e confiável aos usuários.<br />

Agora chega de teoria, vamos a pratica !

> **Vamos provisionar um ambiente com as seguintes ferramentas:**

> [Ansible](https://www.ansible.com/)<br />
> [Amazon EC2 Container Service](https://aws.amazon.com/pt/ecs/)<br />
> [Amazon RDS](https://aws.amazon.com/pt/rds/)<br />
> [Jenkins](https://jenkins.io/index.html)<br />
> [SonarQube](http://www.sonarqube.org/)<br />

> **Como exemplo, vamos utilizar um projeto sample do Java com Gradle, partindo da integração do Jenkins até a disponibilização dos relatórios no Sonar.**

> [SonarExamples](https://github.com/SonarSource/sonar-examples)
