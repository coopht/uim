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
package body UIM.Protocols.Informations is

   -----------
   --  Age  --
   -----------
   function Age (Self : Information) return Positive is
   begin
      return Self.Age;
   end Age;

   ------------
   --  City  --
   ------------
   function City (Self : Information) return Qt4.Strings.Q_String is
   begin
      return Self.City;
   end City;

   ---------------
   --  Country  --
   ---------------
   function Country (Self  : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Country;
   end Country;

   --------------
   --  E_Mail  --
   --------------
   function E_Mail (Self  : Information) return Qt4.Strings.Q_String is
   begin
      return Self.E_Mail;
   end E_Mail;

   --------------
   --  Gender  --
   --------------
   function Gender (Self : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Gender;
   end Gender;

   ----------
   --  Id  --
   ----------
   function Id (Self : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Id;
   end Id;

   ----------------
   --  Language  --
   ----------------
   function Language (Self  : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Language;
   end Language;

   ------------
   --  Name  --
   ------------
   function Name (Self : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Name;
   end Name;

   ----------------
   --  Nickname  --
   ----------------
   function Nickname (Self : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Nickname;
   end Nickname;

   ------------------
   --  Patronymic  --
   ------------------
   function Patronymic (Self  : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Patronymic;
   end Patronymic;

   -------------
   --  Phone  --
   -------------
   function Phone (Self  : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Phone;
   end Phone;

   ---------------
   --  Set_Age  --
   ---------------
   procedure Set_Age (Self : in out Information; Age : Positive) is
   begin
      Self.Age := Age;
   end Set_Age;

   ----------------
   --  Set_City  --
   ----------------
   procedure Set_City (Self  : in out Information;
                       Value : Qt4.Strings.Q_String) is
   begin
      Self.City := Value;
   end Set_City;

   -------------------
   --  Set_Country  --
   -------------------
   procedure Set_Country (Self  : in out Information;
                          Value : Qt4.Strings.Q_String) is
   begin
      Self.Country := Value;
   end Set_Country;

   ------------------
   --  Set_E_Mail  --
   ------------------
   procedure Set_E_Mail (Self  : in out Information;
                         Value : Qt4.Strings.Q_String) is
   begin
      Self.E_Mail := Value;
   end Set_E_Mail;

   ------------------
   --  Set_Gender  --
   ------------------
   procedure Set_Gender (Self  : in out Information;
                         Value : Qt4.Strings.Q_String) is
   begin
      Self.Gender := Value;
      if Self.Gender.Is_Null then
         Self.Gender := Qt4.Strings.From_Utf_8 ("0");
      end if;
   end Set_Gender;

   --------------
   --  Set_Id  --
   --------------
   procedure Set_Id (Self  : in out Information;
                     Value : Qt4.Strings.Q_String) is
   begin
      Self.Id := Value;
   end Set_Id;

   --------------------
   --  Set_Language  --
   --------------------
   procedure Set_Language (Self  : in out Information;
                           Value : Qt4.Strings.Q_String) is
   begin
      Self.Language := Value;
   end Set_Language;

   ----------------
   --  Set_Name  --
   ----------------
   procedure Set_Name (Self  : in out Information;
                       Value : Qt4.Strings.Q_String) is
   begin
      Self.Name := Value;
   end Set_Name;

   --------------------
   --  Set_Nickname  --
   --------------------
   procedure Set_Nickname (Self  : in out Information;
                           Value : Qt4.Strings.Q_String) is
   begin
      Self.Nickname := Value;
   end Set_Nickname;

   ----------------------
   --  Set_Patronymic  --
   ----------------------
   procedure Set_Patronymic (Self  : in out Information;
                             Value : Qt4.Strings.Q_String) is
   begin
      Self.Patronymic := Value;
   end Set_Patronymic;

   -----------------
   --  Set_Phone  --
   -----------------
   procedure Set_Phone (Self  : in out Information;
                        Value : Qt4.Strings.Q_String) is
   begin
      Self.Phone := Value;
   end Set_Phone;

   -------------------
   --  Set_Surname  --
   -------------------
   procedure Set_Surname (Self  : in out Information;
                          Value : Qt4.Strings.Q_String) is
   begin
      Self.Surname := Value;
   end Set_Surname;

   ------------------
   --  Set_Zodiac  --
   ------------------
   procedure Set_Zodiac (Self  : in out Information;
                         Value : Qt4.Strings.Q_String) is
   begin
      Self.Zodiac := Value;
   end Set_Zodiac;

   ---------------
   --  Surname  --
   ---------------
   function Surname (Self  : Information) return Qt4.Strings.Q_String is
   begin
      return Self.Surname;
   end Surname;

   --------------
   --  Zodiac  --
   --------------
   function Zodiac (Self : Information)
      return Qt4.Strings.Q_String is
   begin
      return Self.Zodiac;
   end Zodiac;

end UIM.Protocols.Informations;
