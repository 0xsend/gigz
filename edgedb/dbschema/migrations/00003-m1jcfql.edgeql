CREATE MIGRATION m1jcfqlkbvzh3mud6kiyvugnnrckil4y4vlqd7kvw5kd2fix7p23uq
    ONTO m13mehgioc5mmiofsyfa7cxe2hkilocb3oc32jncet3nqw2dz3x44a
{
  ALTER TYPE default::Session {
      ALTER PROPERTY confirmation_address {
          RESET OPTIONALITY;
      };
  };
};
