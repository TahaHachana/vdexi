import vdexi

client := vdexi.DexiClient.new('DEXI_ACCOUNT_ID', 'DEXI_API_KEY')

execution_id := 'EXECUTION_ID'
execution := client.get_execution(execution_id)!
println(execution)
