import { Clarinet, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can mint tokens for meditation rewards",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get("deployer")!;
    const user1 = accounts.get("wallet_1")!;

    let block = chain.mineBlock([
      Tx.contractCall("zen-token", "mint-meditation-reward", 
        [types.principal(user1.address), types.uint(10)], deployer.address)
    ]);
    
    assertEquals(block.receipts[0].result.expectOk(), true);
    
    let balance = chain.callReadOnlyFn("zen-token", "get-balance", 
      [types.principal(user1.address)], deployer.address);
    assertEquals(balance.result.expectOk(), "10");
  }
});
