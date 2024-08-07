CREATE MIGRATION m13mehgioc5mmiofsyfa7cxe2hkilocb3oc32jncet3nqw2dz3x44a
    ONTO m1fnkev5dnfatnlp33axeaaelgx7inw2dxgld6um3ajjdq6ysesa7a
{
  CREATE GLOBAL default::base_sendpay_address -> std::str {
      SET default := '0x7CE90eF0f63c786C627576cFFa6d942fB55Ae385';
      CREATE ANNOTATION std::description := 'An ethereum address that will receive the confirmation tx';
  };
  ALTER TYPE default::Session {
      ALTER PROPERTY confirmation_address {
          SET default := (GLOBAL default::base_sendpay_address);
      };
      CREATE PROPERTY confirmation_amount: std::bigint {
          SET default := 0;
          SET readonly := true;
          CREATE ANNOTATION std::description := 'The minumum amount of tokens to send to the confirmation address';
          CREATE CONSTRAINT std::min_value(0);
      };
  };
};
