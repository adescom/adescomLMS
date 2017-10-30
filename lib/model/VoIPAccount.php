<?php

/**
 * VoIPAccount
 *
 * @package 
 
 */
class VoIPAccount extends AdescomModel
{
    const PROPERTY_ID = 'id';
    const PROPERTY_OWNER_ID = 'ownerid';
    const PROPERTY_LOGIN = 'login';
    const PROPERTY_PASSWD = 'passwd';
    const PROPERTY_PHONE = 'phone';
    const PROPERTY_ACTIVE = 'active';
    const PROPERTY_TERYT = 'teryt';
    const PROPERTY_LOCATION_CITY = 'location_city';
    const PROPERTY_LOCATION_STREET = 'location_street';
    const PROPERTY_LOCATION_HOUSE = 'location_house';
    const PROPERTY_LOCATION_FLAT = 'location_flat';
    
    protected $id;
    protected $ownerId;
    protected $login;
    protected $passwd;
    protected $phone;
    protected $active;
    protected $teryt;
    protected $locationCity;
    protected $locationStreet;
    protected $locationHouse;
    protected $locationFlat;


    /**
     * Fills model from array
     * 
     * @param array $model Model
     */
    public function fromArray(array $model)
    {
        if (isset($model[self::PROPERTY_ID])) {
            $this->id = $model[self::PROPERTY_ID];
        }
        if (isset($model[self::PROPERTY_OWNER_ID])) {
            $this->ownerId = $model[self::PROPERTY_OWNER_ID];
        }
        if (isset($model[self::PROPERTY_LOGIN])) {
            $this->login = $model[self::PROPERTY_LOGIN];
        }
        if (isset($model[self::PROPERTY_PASSWD])) {
            $this->passwd = $model[self::PROPERTY_PASSWD];
        }
        if (isset($model[self::PROPERTY_PHONE])) {
            $this->phone = $model[self::PROPERTY_PHONE];
        }
        if (isset($model[self::PROPERTY_ACTIVE])) {
            $this->active = $model[self::PROPERTY_ACTIVE];
        }
        if (isset($model[self::PROPERTY_TERYT])) {
            $this->teryt = $model[self::PROPERTY_TERYT];
        }
        if (isset($model[self::PROPERTY_LOCATION_CITY])) {
            $this->locationCity = $model[self::PROPERTY_LOCATION_CITY];
        }
        if (isset($model[self::PROPERTY_LOCATION_STREET])) {
            $this->locationStreet = $model[self::PROPERTY_LOCATION_STREET];
        }
        if (isset($model[self::PROPERTY_LOCATION_HOUSE])) {
            $this->locationHouse = $model[self::PROPERTY_LOCATION_HOUSE];
        }
        if (isset($model[self::PROPERTY_LOCATION_FLAT])) {
            $this->locationFlat = $model[self::PROPERTY_LOCATION_FLAT];
        }
    }

    /**
     * Converts model to array
     * 
     * @param array $model Model
     * @return array Model
     */
    public function toArray(array $model = array())
    {
        $model[self::PROPERTY_ID] = $this->id;
        $model[self::PROPERTY_OWNER_ID] = $this->ownerId;
        $model[self::PROPERTY_LOGIN] = $this->login;
        $model[self::PROPERTY_PASSWD] = $this->passwd;
        $model[self::PROPERTY_PHONE] = array($this->phone);
        $model[self::PROPERTY_ACTIVE] = $this->active;
        $model[self::PROPERTY_TERYT] = $this->teryt;
        $model[self::PROPERTY_LOCATION_CITY] = $this->locationCity;
        $model[self::PROPERTY_LOCATION_STREET] = $this->locationStreet;
        $model[self::PROPERTY_LOCATION_HOUSE] = $this->locationHouse;
        $model[self::PROPERTY_LOCATION_FLAT] = $this->locationFlat;
        return $model;
    }

    public function getId()
    {
        return $this->id;
    }

    public function getOwnerId()
    {
        return $this->ownerId;
    }

    public function getLogin()
    {
        return $this->login;
    }

    public function getPasswd()
    {
        return $this->passwd;
    }

    public function getPhone()
    {
        return $this->phone;
    }

    public function getActive()
    {
        return $this->active;
    }
    
    public function getTeryt()
    {
        return $this->teryt;
    }

    public function getLocationCity()
    {
        return $this->locationCity;
    }

    public function getLocationStreet()
    {
        return $this->locationStreet;
    }

    public function getLocationHouse()
    {
        return $this->locationHouse;
    }

    public function getLocationFlat()
    {
        return $this->locationFlat;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function setOwnerId($ownerId)
    {
        $this->ownerId = $ownerId;
    }

    public function setLogin($login)
    {
        $this->login = $login;
    }

    public function setPasswd($passwd)
    {
        $this->passwd = $passwd;
    }

    public function setPhone($phone)
    {
        $this->phone = $phone;
    }

    public function setActive($active)
    {
        $this->active = $active;
    }

    public function setTeryt($teryt)
    {
        $this->teryt = $teryt;
    }

    public function setLocationCity($locationCity)
    {
        $this->locationCity = $locationCity;
    }

    public function setLocationStreet($locationStreet)
    {
        $this->locationStreet = $locationStreet;
    }

    public function setLocationHouse($locationHouse)
    {
        $this->locationHouse = $locationHouse;
    }

    public function setLocationFlat($locationFlat)
    {
        $this->locationFlat = $locationFlat;
    }

}
