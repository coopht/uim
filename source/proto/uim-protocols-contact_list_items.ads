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
with Ada.Containers.Vectors;

with Qt4.Strings;
with Qt4.Variants;

package UIM.Protocols.Contact_List_Items is

   type Contact_List_Item (Proto_Id : Natural) is tagged private;

   type Contact_List_Item_Access is access all Contact_List_Item'Class;

   package Contact_List_Item_Vectors is
      new Ada.Containers.Vectors (Natural, Contact_List_Item_Access);

   function Name (Self : Contact_List_Item) return Qt4.Strings.Q_String;

   procedure Set_Name (Self : in out Contact_List_Item;
                       Name : Qt4.Strings.Q_String);

   function Children_Length (Self : Contact_List_Item) return Qt4.Q_Integer;

   function Child_At (Self : Contact_List_Item; Pos : Qt4.Q_Integer)
      return Contact_List_Item_Access;

   function Find_Child (Self : Contact_List_Item;
                        Item : Contact_List_Item_Access)
     return Qt4.Q_Integer;

   procedure Append_Child (Self  : in out Contact_List_Item;
                           Child : Contact_List_Item_Access);

   function Parent (Self : Contact_List_Item) return Contact_List_Item_Access;

   function Children (Self : Contact_List_Item)
      return Contact_List_Item_Vectors.Vector;

   function Column_Count (Self : Contact_List_Item)
      return Qt4.Q_Integer;

   function Data (Self : Contact_List_Item; Column : Qt4.Q_Integer)
      return Qt4.Variants.Q_Variant;

   function Row (Self : not null access Contact_List_Item)
      return Qt4.Q_Integer;

private

   type Contact_List_Item (Proto_Id : Natural) is tagged record
      Name     : Qt4.Strings.Q_String;
      Parent   : Contact_List_Item_Access := null;
      Children : Contact_List_Item_Vectors.Vector;
   end record;

end UIM.Protocols.Contact_List_Items;
