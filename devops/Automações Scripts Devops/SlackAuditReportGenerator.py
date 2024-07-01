import os
import json
import pandas as pd

def ler_arquivos_json(diretorio):
    dados = []
    # Listar todos os arquivos no diretório
    for arquivo in os.listdir(diretorio):
        if arquivo.endswith('.json'):
            # Extrair a data do nome do arquivo
            data_arquivo = arquivo.split('.')[0]
            # Caminho completo para o arquivo
            caminho_completo = os.path.join(diretorio, arquivo)
            with open(caminho_completo, 'r', encoding='utf-8') as f:
                conteudo = json.load(f)
                # Extrair dados de cada mensagem
                for mensagem in conteudo:
                    data_mensagem = {
                        'date': data_arquivo,
                        'real_name': mensagem.get('user_profile', {}).get('real_name', ''),
                        'name': mensagem.get('user_profile', {}).get('name', ''),
                        'display_name': mensagem.get('user_profile', {}).get('display_name', ''),
                        'text': mensagem.get('text', ''),
                        'value': mensagem.get('value', '')
                    }
                    dados.append(data_mensagem)
    return dados

def main():
    base_dir = '.'  # Diretório onde o script é executado
    output_dir = os.path.join(base_dir, 'excel_outputs')
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    todos_dados = []

    # Cria um DataFrame para armazenar os dados de todos os canais
    for canal in os.listdir(base_dir):
        caminho_canal = os.path.join(base_dir, canal)
        if os.path.isdir(caminho_canal):
            dados_canal = ler_arquivos_json(caminho_canal)
            if dados_canal:
                # Adiciona os dados do canal ao DataFrame geral
                df_canal = pd.DataFrame(dados_canal)
                todos_dados.append(df_canal)
                # Salva os dados do canal em um arquivo Excel no diretório de saída
                df_canal.to_excel(os.path.join(output_dir, f'{canal}.xlsx'), index=False)

    # Combina todos os dados em um único DataFrame e salva em um arquivo Excel no diretório de saída
    if todos_dados:
        df_todos = pd.concat(todos_dados, ignore_index=True)
        df_todos.to_excel(os.path.join(output_dir, 'dados_todos_canais.xlsx'), index=False)

if __name__ == '__main__':
    main()

