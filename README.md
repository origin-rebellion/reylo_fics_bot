# reylo_fics_bot

This is the script creating the RSS feed that Zapier uses to send tweets to [@reylo_fic](https://twitter.com/reylo_fic]) on twitter. It reads a custom RSS feed from the "Rey/Ben Solo | Kylo Ren" page on Archive Of Our Own and re-formats the data to automatically tweet when the "Rey/Ben Solo | Kylo Ren" page is updated.

It's a simple serverless Ruby function. This repo only contains the code for that function, but it runs on [faasd](https://github.com/openfaas/faasd). I suggest following [this tutorial from the OpenFaaS blog](https://www.openfaas.com/blog/faasd-tls-terraform/) to set something like this up.

Feel free to fork it; it's on github for transparency as to how the @reylo_fic bot is run.
