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
--  * Neither the name of the Alexander Basov, IE nor the names of its        --
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
with Qt4.Abstract_Item_Models;
with Qt4.Model_Indices;
with Qt4.Variants;
private with Qt4.Abstract_Item_Models.Directors;

with UIM.Protocols.Contact_List_Items;

package UIM.Protocols.Contact_List_Models is

   use UIM.Protocols.Contact_List_Items;

   type Contact_List_Model is limited
     new Qt4.Abstract_Item_Models.Q_Abstract_Item_Model
     with private;

   type Contact_List_Model_Access is access all Contact_List_Model;

   function Create return Contact_List_Model_Access;

   function To_Item
    (Self  : not null access constant Contact_List_Model'Class;
     Index : Qt4.Model_Indices.Q_Model_Index)
       return UIM.Protocols.Contact_List_Items.Contact_List_Item_Access;

   procedure Add_Item
    (Self   : not null access Contact_List_Model;
     Parent :          access Contact_List_Item'Class := null;
     Child  : not null access Contact_List_Item'Class);

private

   type Contact_List_Model is limited
     new Qt4.Abstract_Item_Models.Directors.Q_Abstract_Item_Model_Director
     with record
        Root : UIM.Protocols.Contact_List_Items.Contact_List_Item_Access;
   end record;

   overriding function Column_Count
    (Self   : not null access constant Contact_List_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Q_Integer;

   overriding function Data
    (Self  : not null access Contact_List_Model;
     Index : Qt4.Model_Indices.Q_Model_Index;
     Role  : Qt4.Item_Data_Role)
       return Qt4.Variants.Q_Variant;

   overriding function Has_Children
    (Self   : not null access constant Contact_List_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Boolean;

   overriding function Header_Data
    (Self        : not null access Contact_List_Model;
     Section     : Qt4.Q_Integer;
     Orientation : Qt4.Orientations;
     Role        : Qt4.Item_Data_Role)
       return Qt4.Variants.Q_Variant;

   overriding function Index
    (Self   : not null access constant Contact_List_Model;
     Row    : Qt4.Q_Integer;
     Column : Qt4.Q_Integer := 0;
     Parent : Qt4.Model_Indices.Q_Model_Index := Qt4.Model_Indices.Create)
       return Qt4.Model_Indices.Q_Model_Index;

   overriding function Parent
    (Self  : not null access constant Contact_List_Model;
     Child : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Model_Indices.Q_Model_Index;

   overriding function Row_Count
    (Self   : not null access constant Contact_List_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Q_Integer;

end UIM.Protocols.Contact_List_Models;
