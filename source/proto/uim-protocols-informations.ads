------------------------------------------------------------------------------
--                                                                          --
--                               UIM Project                                --
--                                                                          --
--                Multi protocol instant messenger for unix                 --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Alexander Basov <coopht@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Alexander Basov, IE nor the names of its      --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Qt_Ada.Generic_Variants;
with Qt4.Strings;

package UIM.Protocols.Informations is

   type Information is tagged private;

   type Information_Access is access all Information'Class;

   --  Public Api

   procedure Set_Age (Self : in out Information; Age : Positive);

   function Age (Self : Information) return Positive;

   procedure Set_Id (Self  : in out Information;
                     Value : Qt4.Strings.Q_String);

   function Id (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Nickname (Self  : in out Information;
                            Value : Qt4.Strings.Q_String);

   function Nickname (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Name (Self  : in out Information;
                       Value : Qt4.Strings.Q_String);

   function Name (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Surname (Self  : in out Information;
                          Value : Qt4.Strings.Q_String);

   function Surname (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Patronymic (Self : in out Information;
                             Value : Qt4.Strings.Q_String);

   function Patronymic (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_E_Mail (Self  : in out Information;
                         Value : Qt4.Strings.Q_String);

   function E_Mail (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Phone (Self  : in out Information;
                        Value : Qt4.Strings.Q_String);

   function Phone (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Gender (Self  : in out Information;
                         Value : Qt4.Strings.Q_String);

   function Gender (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Zodiac (Self  : in out Information;
                         Value : Qt4.Strings.Q_String);

   function Zodiac (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Language (Self  : in out Information;
                           Value : Qt4.Strings.Q_String);

   function Language (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_City (Self  : in out Information;
                       Value : Qt4.Strings.Q_String);

   function City (Self : Information) return Qt4.Strings.Q_String;

   procedure Set_Country (Self  : in out Information;
                          Value : Qt4.Strings.Q_String);

   function Country (Self : Information) return Qt4.Strings.Q_String;

   package Information_Variant is
      new Qt_Ada.Generic_Variants (Information_Access, "Information_Access");

private

   type Information is tagged
      record
      --  ID - icq number of jabber e-mail address.
      Id         : Qt4.Strings.Q_String;
      Nickname   : Qt4.Strings.Q_String;
      Name       : Qt4.Strings.Q_String;
      Surname    : Qt4.Strings.Q_String;
      Patronymic : Qt4.Strings.Q_String;
      E_Mail     : Qt4.Strings.Q_String;
      Phone      : Qt4.Strings.Q_String;
      Gender     : Qt4.Strings.Q_String;
      Location   : Qt4.Strings.Q_String;
      Zodiac     : Qt4.Strings.Q_String;
      City       : Qt4.Strings.Q_String;
      Country    : Qt4.Strings.Q_String;
      Age        : Positive;
      Language   : Qt4.Strings.Q_String;
      --  XXX Add extended user information, that is specific for such proto,
      --  like ICQ
   end record;

end UIM.Protocols.Informations;
