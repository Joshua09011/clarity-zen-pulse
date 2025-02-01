import { Clarinet, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can create meditation session",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get("deployer")!;
    
    let block = chain.mineBlock([
      Tx.contractCall("meditation-session", "create-session",
        [
          types.ascii("Peaceful Morning"),
          types.uint(15),
          types.buff(Buffer.from("musicHash")),
          types.ascii("4-7-8"),
          types.uint(10)
        ],
        deployer.address)
    ]);

    assertEquals(block.receipts[0].result.expectOk(), "1");
  }
});
