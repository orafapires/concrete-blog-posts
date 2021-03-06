# Implementando a Análise Estática na Integração Contínua

Durante o desenvolvimento de um software, é comum encontrarmos bugs, más práticas e  problemas relacionados a estilo.<br />
A análise estática visa evidenciar esses problemas e é parte fundamental no processo de melhoria da qualidade do código-fonte.<br />
Com essa prática adotada em tempo de desenvolvimento, será muito menos dolorosa a entrega em produção e os possíveis prejuizos financeiros, operacionais e de manutenção gerados por esses problemas podem diminuir drasticamente.<br />
Da mesma forma, o uso de boas práticas de orientação a objetos permite que o código seja flexível e suporte mudanças de forma mais tranquila, segura e natural.<br />
Partindo desse contexto, a etapa da qualidade se torna extremamente relevante no processo da Integração Contínua, pois é por meio dela que poderemos entregar um software mais íntegro e confiável aos usuários.<br />

Tudo entendido? Agora chega de teoria, vamos à pratica!<br />

> **Vamos provisionar um ambiente com as seguintes ferramentas:**

<img align="left" src="docker.png">
<img align="left" src="jenkins.png">
<img align="left" src="sonarqube.png">
<br />
<br />
<br />
<br />
<br />
<br />
<br />

> **Como exemplo, vamos utilizar um projeto sample do Sonar com Java, partindo da integração do Jenkins até a disponibilização dos relatórios no Sonar.**

> [SonarExamples](https://github.com/SonarSource/sonar-examples)<br />

Falando sobre o Sonar, o sistema avalia mais de 20 linguagens, baseando-se em métricas pré-configuradas ou personalizadas (criadas) para o seu projeto.
Com essas métricas, a Integração Contínua pode ou não promover um artefato em um ambiente de desenvolvimento, testes ou de produção.

Vamos partir da ideia de que você já está com o Docker instalado. Agora, vamos realizar o download e executar o script para provisionar o nosso ambiente local:

```bash
curl https://raw.githubusercontent.com/orafapires/concrete-blog-posts/master/04_2016/ScriptAnaliseEstatica.sh > /tmp/ScriptAnaliseEstatica.sh
cd /tmp
chmod a+x ScriptAnaliseEstatica.sh
./ScriptAnaliseEstatica.sh
```

**Uma boa prática é subir o Sonar já apontando para um SGBD voltado para produção, como o MySQL ou o Postgres, por exemplo.**<br />

**Anote os IPs gerados pelo script e vamos pra cima!** :wink:

Vamos iniciar as configurações no Jenkins:
> http://IPdoJenkins:8080

Agora, vamos instalar os plugins necessários, navegando até:
> * Gerenciar Jenkins
> * Gerenciar Plugins
> * Clique na aba **Disponíveis**
> * Instale o seguinte plugin: **SonarQube Plugin**
> * Instale o seguinte plugin: **Git plugin** (Requer reinicialização do Jenkins)

Após as instalações, é necessário configurarmos os plugins do Sonar em:
> * Gerenciar Jenkins
> * Configurar o sistema
> * SonarQube Runner
> * SonarQube

**Preencher os dados conforme as figuras abaixo:**

<img align="center" src="sonarrunner.png"><br />
---
<img align="center" src="sonarexample.png">

> **Os dados de acesso ao Sonar são os dados default do sistema:**<br />
> Usuário: **admin**<br />
> Senha: **admin**

Com os plugins instalados e configurados, podemos criar o nosso Job de exemplo.<br />
Vamos nomeá-lo de **"SonarExemplo"** e criá-lo como um projeto **Free Style**.<br />
Em **Gerenciamento de código-fonte**, insira o seguinte repositório:

> https://github.com/SonarSource/sonar-examples.git

A branch **master** deve ser mantida.<br />
No step de **Build**, selecione **Invoke Standalone SonarQube Analysis**.<br />
Em **Analysis properties**, preencha com os seguintes dados:

```Java
# Required metadata
sonar.projectKey=org.sonarqube:java-simple-sq-scanner
sonar.projectName=Java :: Simple Project Not Compiled :: SonarQube Scanner
sonar.projectVersion=1.0

# Comma-separated paths to directories with sources (required)
sonar.sources=$WORKSPACE/projects/languages/java/sonar-runner/java-sonar-runner-simple/src

# Language
sonar.language=java

# Encoding of the source files
sonar.sourceEncoding=UTF-8
```

Com esses passos realizados, poderemos executar o nosso build e visualizar os resultados no Sonar.<br />
O Jenkins disponibiliza a URL de acesso aos relatórios no próprio Job, conforme figura abaixo:

<img align="center" src="sonarlink.png">
<br />

Partiu Sonar ? :sunglasses:

<img align="center" src="sonarresults.png">
<br />

Em um próximo post, vamos abordar as métricas do sistema e adequar à realidade do seu projeto! Ficou alguma dúvida ou tem alguma sugestão? Aproveite os campos abaixo!  
Até a próxima.
